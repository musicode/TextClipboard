/**
 * @file html 复制
 * @author musicode
 */
define(function (require, exports, module) {

    'use strict';

    /**
     * @constructor
     * @param {Object} options
     * @property {jQuery} options.element 按钮元素
     * @property {?Function} options.onClick 点击按钮元素的回调
     */
    function HTMLClipboard(options) {
        $.extend(this, options);
        this.init();
    }

    HTMLClipboard.prototype = {

        constructor: HTMLClipboard,

        init: function () {
            var me = this;
            var onClick = me.onClick;
            if (onClick) {
                me.clickHandler = function () {
                    return onClick.call(me);
                };
                me.element.on('click', me.clickHandler);
            }
        },

        copy: function (text) {

            var textarea = document.createElement('textarea');
            textarea.value = text;
            textarea.style.position = 'absolute';
            textarea.style.left = '9999px';
            document.body.appendChild(textarea);

            textarea.select();
            textarea.setSelectionRange(0, text.length);

            var result = false;
            try {
                result = document.execCommand('copy');
                setTimeout(
                    function () {
                        document.body.removeChild(textarea);
                    }
                );
            }
            catch (e) { }

            return result;

        },

        dispose: function () {
            var clickHandler = this.clickHandler;
            if (clickHandler) {
                this.element.off('click', clickHandler);
            }
        }
    };

    return HTMLClipboard;

});