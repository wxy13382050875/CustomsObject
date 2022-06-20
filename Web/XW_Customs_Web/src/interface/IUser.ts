export interface IUser {
    id?: number;
    appId: string | number | undefined;
    code: string;
    username: string;
    password: string;
    trueName: string;
    alias: string;
    pic: string;
    phone: number | undefined;
    email: string;
    sex: string;
    papersType: string | undefined;
    papersNo: string;
    type: string;
    orgIds: number[];
    roleIds: number[];
}

export const columns = [
    {
        title: "所属应用",
        dataIndex: "appId",
        width: "120px"
    },
    {
        title: "编码",
        dataIndex: "code",
        width: "120px"
    },
    {
        title: "用户名",
        dataIndex: "username",
        width: "120px"
    },
    {
        title: "真实姓名",
        dataIndex: "trueName",
        width: "120px"
    },
    {
        title: "别名",
        dataIndex: "alias",
        width: "120px"
    },
    {
        title: "头像",
        dataIndex: "pic",
        width: "120px"
    },
    {
        title: "手机号",
        dataIndex: "phone",
        width: "120px"
    },
    {
        title: "邮箱",
        dataIndex: "email",
        width: "120px"
    },
    {
        title: "性别",
        dataIndex: "sex",
        width: "120px"
    },
    {
        title: "证件类型",
        dataIndex: "papersType",
        width: "150px"
    },
    {
        title: "证件号码",
        dataIndex: "papersNo",
        width: "240px"
    },
    {
        title: "用户类型",
        dataIndex: "type",
        width: "120px"
    },
    {
        title: "操作",
        dataIndex: "operation",
        fixed: "right",
        width: "240px"
    }
];
export const unitColumns = [
    {
        title: "委托单位名称",
        dataIndex: "name",
        width: "120px"
    },
    {
        title: "委托单位类型",
        dataIndex: "type",
        width: "120px"
    },
    {
        title: "地址",
        dataIndex: "address",
        width: "120px"
    },
    {
        title: "联系人",
        dataIndex: "contacts",
        width: "120px"
    },
    {
        title: "电话",
        dataIndex: "phone",
        width: "120px"
    },
    {
        title: "传真",
        dataIndex: "fax",
        width: "120px"
    },
    {
        title: "邮箱",
        dataIndex: "email",
        width: "120px"
    }
];