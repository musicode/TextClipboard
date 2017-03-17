/**
 * @file flash 实现的文本复制
 * @author musicode
 */
define(function (require, exports, module) {

    'use strict';

    var HTMLClipboard = require('./HTMLClipboard');
    var FlashClipboard = require('./FlashClipboard');

    /**
     * @constructor
     * @param {Object} options
     * @property {jQuery} options.element 按钮元素
     * @property {?Function} options.onClick 点击按钮元素的回调
     */
    function TextClipboard(options) {
        this.init(options);
    };

    TextClipboard.prototype = {

        constructor: TextClipboard,

        init: function (options) {

            var me = this;

            $.extend(me, options);

            var onClick = options.onClick;
            if (onClick) {
                options.onClick = function () {
                    return onClick.call(me);
                };
            }

            var clipboard;

            if (document.queryCommandSupported
                && document.queryCommandSupported('copy')
            ) {
                options.element.css({
                    position: 'absolute',
                    left: 0,
                    top: 0,
                    width: '100%',
                    height: '100%'
                });
                clipboard = new HTMLClipboard(options);
            }
            else {
                clipboard = new FlashClipboard(options);
            }

            me.clipboard = clipboard;

        },

        copy: function (text) {
            return this.clipboard.copy(text);
        },

        dispose: function () {
            this.clipboard.dispose();
        }

    };

    TextClipboard.version = '0.0.4';

    return TextClipboard;

});