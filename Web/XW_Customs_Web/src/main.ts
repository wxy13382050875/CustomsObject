import { createApp } from "vue";
import Antd from "ant-design-vue";
import "./public-path.js";
import "ant-design-vue/dist/antd.css";
import * as Icons from "@ant-design/icons-vue";
import App from "./App.vue";
import ListContainer from "@/components/ListContainer.vue";
import ShowContainer from "@/components/ShowContainer.vue";
import OrgTree from "@/components/common/OrgTree.vue";
import AppSelect from "@/components/common/AppSelect.vue";

import router from "./router";
import { store, key } from "./store";

function render(props: any) {
    const { container } = props;
    
    const app = createApp(App);
    
    type IconsType = keyof typeof Icons;
    Object.keys(Icons).forEach((key: any) => {
        app.component(key, Icons[key as IconsType]);
    });

    app.component("ListContainer", ListContainer);
    app.component("ShowContainer", ShowContainer);
    app.component("OrgTree", OrgTree);
    app.component("AppSelect", AppSelect);
    
    app.use(store, key);
    app.use(router);
    app.use(Antd);
    app.mount(container ? container.querySelector("#app") : "#app");
}

// 独立运行时
if (!(window as any).__POWERED_BY_QIANKUN__) {
    render({});
}

declare global {
    interface Window {
        app: any;
    }
}

console.log(store.state.sys.isQianKun);

window.app = {
    bootstrap: () => {
        console.log("bootstrap");
        return Promise.resolve();
    },
    mount: (props: any) => {
        console.log("mount");
        render(props);
        return Promise.resolve();
    },
    unmount: () => {
        console.log("unmount");
        return Promise.resolve();
    }
};
