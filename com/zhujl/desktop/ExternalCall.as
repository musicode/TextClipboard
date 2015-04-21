/**
 * @file 外部接口文件, 方便查看对外暴露的接口
 * @author zhujl
 */
package com.zhujl.desktop {

    import flash.external.ExternalInterface;

    public class ExternalCall {

        private var movieName: String;

        public function ExternalCall(movieName: String = '') {
            this.movieName = movieName;
        }

        public function ready(): void {
            call('onReady');
        }

        public function click(): void {
            call('onClick');
        }


        private function call(name: String, data: Object = null): void {
            var prefix: String = 'TextClipboard.instances["' + movieName + '"].';
            ExternalInterface.call(prefix + name, data);
        }

        public function addCallback(name: String, fn: Function): void {
            ExternalInterface.addCallback(name, fn);
        }

    }
}
