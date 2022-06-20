export const MenuList = [
    {
        url: "/orgList",
        name: "用户列表",
        id: 1,
        children: []
    },
    {
        url: "/unitList",
        name: "委托单位",
        id: 1,
        children: []
    },
    {
        url: "/permission",
        name: "权限管理",
        children: []
    },
    {
        url: "/",
        name: "机构管理",
        children: [
            {
                url: "/org",
                name: "机构列表"
            }
        ]
    },
    {
        url: "/",
        name: "角色管理",
        children: [
            // {
            //     url: "/sysRoleList",
            //     name: "系统角色"
            // },
            {
                url: "/orgRoleList",
                name: "机构角色"
            }]
    },
    // {
    //     url: "/app",
    //     name: "应用管理",
    //     children: []
    // }
];
