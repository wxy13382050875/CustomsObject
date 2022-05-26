//import { pathToRegexp } from "path-to-regexp";

// 简单的通过递归获取到了所有权限url
export function getAuthRouters(authMenu: any[]) {
    let authRouters: any = [];
    (authMenu || []).forEach((item: any) => {
        const { url, children } = item;
        url && authRouters.push(url);
        if (children && children.length > 0) {
            authRouters = [...authRouters, ...getAuthRouters(children)];
        }
    });
    return authRouters;
}

export function createAuthRouters(authRouters: any) {
    const isAuthUrl = (url: any) => {
        return (authRouters || []).some((cUrl: any) => {
            //TODO 正则还不会使用
            //return pathToRegexp(url).toString() === pathToRegexp(cUrl).toString();

            return url.includes(cUrl);
        });
    };
    return function createRouters(routers: any, upperPath: any) {
        const nRouters: any = [];
        (routers || []).forEach((item: any) => {
            const { children, path, name } = item;
            let isMatched = false;
            const nItem = { ...item };
            const fullPath = `${upperPath || ""}/${path}`.replace(/\/{2,}/, "/");
            let nChildren = null;
            children && (nChildren = createRouters(children, fullPath));
            // 1.当前路由匹配
            if (isAuthUrl(fullPath)) {
                isMatched = true;
            }
            // 2.存在子路由匹配
            if (nChildren && nChildren.length > 0) {
                nItem.children = nChildren;
                isMatched = true;
            }
            // 特殊处理(不需要可以删除)
            if (name === "home") {
                isMatched = true;
            }
            // nItem
            isMatched && nRouters.push(nItem);
        });
        return nRouters;
    };
}
