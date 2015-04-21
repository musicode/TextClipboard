package com.zhujl.desktop {

    import flash.display.Sprite;
    import flash.events.MouseEvent;

    import flash.system.Security;

    import flash.desktop.Clipboard;
    import flash.desktop.ClipboardFormats;

    /**
     * 初始化参数
     *
     * @param {String} text
     */
    public class TextClipboard extends Sprite {

        private var externalCall: ExternalCall;

        private var clipboard: Clipboard;

        private var params: Object;

        public function TextClipboard() {

            initEnv();
            initExternal();

            clipboard = Clipboard.generalClipboard;

            stage.addEventListener(
                MouseEvent.CLICK,
                onClick
            );

            externalCall.ready();

        }

        private function initEnv(): void {
            Security.allowDomain('*');
            Security.allowInsecureDomain('*');
        }

        private function initExternal(): void {

            params = stage.loaderInfo.parameters;
            trace('1111')
/**
            params = {
                movieName: '_TextClipboard_0',
                text: 'haha1'
            };
*/
            externalCall = new ExternalCall(params.movieName);
            externalCall.addCallback('copy', copy);
            externalCall.addCallback('paste', paste);
            externalCall.addCallback('clear', clear);
            externalCall.addCallback('dispose', dispose);

        }

        private function onClick(e: MouseEvent): void {
            if (params.text) {
                copy(params.text);
            }
            externalCall.click();
        }

        public function copy(value: String): void {
            clear();
            clipboard.setData(ClipboardFormats.TEXT_FORMAT, value);
        }

        public function paste(): String {
            if (clipboard.hasFormat(ClipboardFormats.TEXT_FORMAT)) {
                return clipboard.getData(ClipboardFormats.TEXT_FORMAT) as String;
            }
            else {
                return '';
            }
        }

        public function clear(): void {
            clipboard.clear();
        }

        public function dispose(): void {
            stage.removeEventListener(
                MouseEvent.CLICK,
                onClick
            );
        }

    }
}