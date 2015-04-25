package com.zhujl.desktop {

    import flash.display.Sprite;
    import flash.events.MouseEvent;

    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
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

        private var button: Sprite;

        private var params: Object;

        public function TextClipboard() {

            initEnv();
            initExternal();

            // 不创建按钮，会有各种穿透问题
            initButton();

            clipboard = Clipboard.generalClipboard;

            if (params.text) {
                copy(params.text);
            }

            externalCall.ready();
            this.graphics.beginFill(0xFF0000, 1);
            this.graphics.drawRect(0, 0, stage.width, stage.height);
            this.graphics.endFill();
        }

        /**
         * 这段必须写
         */
        private function initEnv(): void {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            Security.allowDomain('*');
            Security.allowInsecureDomain('*');
        }

        private function initExternal(): void {

            params = stage.loaderInfo.parameters;

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

        private function initButton(): void {

            button = new Sprite();

            // 这里不能指定 btn 的大小
            // 因为默认的习惯是让内容撑开容器
            // 如果设置为舞台的大小，因为舞台还没有任何东西，所以高宽为 0
            button.graphics.beginFill(0x00FF00, 0.5);
            button.graphics.drawRect(0, 0, 200, 200);
            button.graphics.endFill();

            button.buttonMode = true;

            stage.addChild(button);

            button.addEventListener(
                MouseEvent.CLICK,
                onClick
            );
        }

        private function onClick(e: MouseEvent): void {
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