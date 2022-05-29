export interface IPermission {
    appId: number;
    name: string;
    type: "WEB" | "MOBILE" | undefined;
    path: string;
    icon: string;
    sort: number;
    note: string;
    enabled: boolean;
}

export const columns = [
    {
        title: "菜单名称",
        dataIndex: "name",
        key: "name"
    },
    {
        title: "菜单图标",
        dataIndex: "icon",
        key: "icon"
    },
    {
        title: "Web地址",
        dataIndex: "path",
        key: "path"
    },
    {
        title: "Android地址",
        dataIndex: "androidPath",
        key: "androidPath"
    },
    {
        title: "Ios地址",
        dataIndex: "iosPath",
        key: "iosPath"
    },
    
    {
        title: "排序",
        dataIndex: "sort",

        key: "sort"
    },
    {
        title: "状态",
        dataIndex: "enabled",
        key: "enabled"
    },
    {
        title: "操作",
        width: "250px",
        fixed: "right",
        dataIndex: "operation"
    }
];
