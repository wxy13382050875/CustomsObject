export const MenuList = [
    {
        url: "/user",
        name: "用户列表",
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
        url: "/role",
        name: "角色管理",
        children: []
    },
    // {
    //     url: "/app",
    //     name: "应用管理",
    //     children: []
    // }
];
