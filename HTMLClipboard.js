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

            var textarea = $('<textarea></textarea>');
            textarea.prop('value', text);
            textarea.css({
                position: 'absolute',
                left: 0,
                top: 0,
                width: 1,
                height: 1
            });
            textarea.appendTo('body');

            textarea[0].select();
            textarea[0].setSelectionRange(0, text.length);

            var result = false;
            try {
                result = document.execCommand('copy');
                setTimeout(
                    function () {
                        textarea.remove();
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