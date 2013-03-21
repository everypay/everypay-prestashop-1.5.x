(function() {
    var _this = this;

    this.Everypay = (function() {

        function Everypay() {}

        Everypay.version = 1;
        
        Everypay.error = false;

        Everypay.baseAddress = 'http://api.everypay.local';

        Everypay.validateCardNumber = function(num) {
            num = (num + '').replace(/\s+|-/g, '');
            return num.length >= 10 && num.length <= 16 && Everypay.luhnCheck(num);
        };

        Everypay.validateCVV = function(num) {
            num = Everypay.trim(num);
            return /^\d+$/.test(num) && num.length >= 3 && num.length <= 4;
        };

        Everypay.validateExpiry = function(month, year) {
            var currentTime, expiry;
            month = Everypay.trim(month);
            year = Everypay.trim(year);
            if (!/^\d+$/.test(month)) {
                return false;
            }
            if (!/^\d+$/.test(year)) {
                return false;
            }
            if (!(parseInt(month, 10) <= 12)) {
                return false;
            }
            expiry = new Date(year, month);
            currentTime = new Date;
            expiry.setMonth(expiry.getMonth() - 1);
            expiry.setMonth(expiry.getMonth() + 1, 1);
            return expiry > currentTime;
        };

        Everypay.cardType = function(num) {
            return Everypay.cardTypes[num.slice(0, 2)] || 'Unknown';
        };

        Everypay.setPublicKey = function(key) {
            Everypay.key = key;
        };

        Everypay.createToken = function(card, params, callback) {
            var amount, key, value;
            if (params == null) {
                params = {};
            }
            if (!card) {
                throw 'card required';
            }
            if (typeof card !== 'object') {
                throw 'card invalid';
            }
            
            if (typeof params === 'function') {
                callback = params;
                params = {};
            } else if (typeof params !== 'object') {
                amount = parseInt(params, 10);
                params = {};
                if (amount > 0) {
                    params.amount = amount;
                }
            }
            for (key in card) {
                value = card[key];
                params[key] = value;
            }
            params.key || (params.key = Everypay.key || Everypay.pubicKey);
            return Everypay.ajaxJSONP({
                url: "" + Everypay.baseAddress + "/tokens",
                data: params,
                method: 'POST',
                success: function(body, status) {
                    return typeof callback === "function" ? callback(status, body) : void 0;
                },
                complete: Everypay.complete(callback),
                timeout: 40000
            });
        };

        Everypay.getToken = function(token, callback) {
            if (!token) {
                throw 'token required';
            }
            Everypay.validateKey(Everypay.key);
            return Everypay.ajaxJSONP({
                url: "" + Everypay.baseAddress + "/tokens/" + token,
                data: {
                    key: Everypay.key
                },
                success: function(body, status) {
                    return typeof callback === "function" ? callback(status, body) : void 0;
                },
                complete: Everypay.complete(callback),
                timeout: 40000
            });
        };

        Everypay.complete = function(callback) {
            return function(type, xhr, options) {
                if (type !== 'success') {
                    return typeof callback === "function" ? callback(500, {
                        error: {
                            code: type,
                            type: type,
                            message: 'An unexpected error has occured.\nEverypay will be notified about this.'
                        }
                    }) : void 0;
                }
            };
        };

        Everypay.validateKey = function(key) {
            if (!key || typeof key !== 'string') {
                throw new Error('You did not set a valid public key.\nCall Everypay.setPublicKey() with your public key.\n');
            }
            if (/^sk_/.test(key)) {
                throw new Error('You are using a secret key with Everypay.js, instead of the public one.\n');
            }
        };
        
        
        Everypay.validateCardData = function(card) {
            Everypay.error = false;
            
            if (!card) {
                Everypay.error = 'card required';                
            }
            if (typeof card !== 'object') {
                Everypay.error = 'card invalid';
            }
            if (!this.validateCardNumber(card.card_number)) {
                Everypay.error = 'invalid card number';
            }
            if (!this.validateCVV(card.cvv)) {
                Everypay.error = 'invalid cvv number';
            } 
            if (!this.validateExpiry(card.expiration_month, card.expiration_year)) {
                Everypay.error = 'invalid card expiry date';
            }
            //console.log(this.error)
            if (Everypay.error){
                return true;
            } else {
                return false;
            }
        };

        return Everypay;

    }).call(this);

    if (typeof module !== "undefined" && module !== null) {
        module.exports = this.Everypay;
    }

    if (typeof define === "function") {
        define('stripe', [], function() {
            return _this.Everypay;
        });
    }

}).call(this);
(function() {
    var e, requestID, serialize,
    __slice = [].slice;

    e = encodeURIComponent;

    requestID = new Date().getTime();

    serialize = function(object, result, scope) {
        var key, value;
        if (result == null) {
            result = [];
        }
        for (key in object) {
            value = object[key];
            if (scope) {
                key = "" + scope + "[" + key + "]";
            }
            if (typeof value === 'object') {
                serialize(value, result, key);
            } else {
                result.push("" + key + "=" + (e(value)));
            }
        }
        return result.join('&').replace(/%20/g, '+');
    };

    this.Everypay.ajaxJSONP = function(options) {
        var abort, abortTimeout, callbackName, head, script, xhr;
        if (options == null) {
            options = {};
        }
        callbackName = 'ev_jsonp' + (++requestID);
        script = document.createElement('script');
        abortTimeout = null;
        abort = function() {
            var _ref;
            if ((_ref = script.parentNode) != null) {
                _ref.removeChild(script);
            }
            if (callbackName in window) {
                window[callbackName] = (function() {});
            }
            return typeof options.complete === "function" ? options.complete('abort', xhr, options) : void 0;
        };
        xhr = {
            abort: abort
        };
        script.onerror = function() {
            xhr.abort();
            return typeof options.error === "function" ? options.error(xhr, options) : void 0;
        };
        window[callbackName] = function() {
            var args;
            args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
            clearTimeout(abortTimeout);
            script.parentNode.removeChild(script);
            try {
                delete window[callbackName];
            } catch (e) {
                window[callbackName] = void 0;
            }
            if (typeof options.success === "function") {
                options.success.apply(options, args);
            }
            return typeof options.complete === "function" ? options.complete('success', xhr, options) : void 0;
        };
        options.data || (options.data = {});
        options.data.callback = callbackName;
        if (options.method) {
            options.data._method = options.method;
        }
        script.src = options.url + '?' + serialize(options.data);        
        head = document.getElementsByTagName('head')[0];
        head.appendChild(script);
        if (options.timeout > 0) {
            abortTimeout = setTimeout(function() {
                xhr.abort();
                return typeof options.complete === "function" ? options.complete('timeout', xhr, options) : void 0;
            }, options.timeout);
        }
        return xhr;
    };

}).call(this);
(function() {

    this.Everypay.trim = function(str) {
        return (str + '').replace(/^\s+|\s+$/g, '');
    };

    this.Everypay.underscore = function(str) {
        return (str + '').replace(/([A-Z])/g, function($1) {
            return "_" + ($1.toLowerCase());
        });
    };

    this.Everypay.luhnCheck = function(num) {
        var digit, digits, odd, sum, _i, _len;
        odd = true;
        sum = 0;
        digits = (num + '').split('').reverse();
        for (_i = 0, _len = digits.length; _i < _len; _i++) {
            digit = digits[_i];
            digit = parseInt(digit, 10);
            if ((odd = !odd)) {
                digit *= 2;
            }
            if (digit > 9) {
                digit -= 9;
            }
            sum += digit;
        }
        return sum % 10 === 0;
    };

    this.Everypay.cardTypes = (function() {
        var num, types, _i, _j;
        types = {};
        for (num = _i = 40; _i <= 49; num = ++_i) {
            types[num] = 'Visa';
        }
        for (num = _j = 50; _j <= 59; num = ++_j) {
            types[num] = 'MasterCard';
        }
        types[34] = types[37] = 'American Express';
        types[60] = types[62] = types[64] = types[65] = 'Discover';
        types[35] = 'JCB';
        types[30] = types[36] = types[38] = types[39] = 'Diners Club';
        return types;
    })();

}).call(this);