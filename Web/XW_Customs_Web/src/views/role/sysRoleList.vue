<script setup lang="ts">
import { computed, reactive, ref } from "vue";
import { FormInstance } from "ant-design-vue";
import { usePagination } from "vue-request";
import { getRoleList } from "@/api/role";
import { useOrgTree } from "@/utils/hooks";
import { message, Form, Modal, TreeSelect } from "ant-design-vue";
import { addRole, updateRole, getRolePermission, saveRoleForPermission, deleteRole } from "@/api/role";
import { store } from "@/store";
const useForm = Form.useForm;
//定义参数类型
const SHOW_ALL = TreeSelect.SHOW_ALL;
const columns = [
    {
        title: "角色名称",
        dataIndex: "name",
        key: "name"
    },
    {
        title: "角色编码",
        dataIndex: "code",
        key: "code"
    },
    {
        title: "状态",
        dataIndex: "enabled",
        key: "enabled"
    },
    {
        title: "备注",
        dataIndex: "note",
        key: "note"
    },
    {
        title: "操作",
        width: "250px",
        fixed: "right",
        dataIndex: "operation"
    }
];
//查询用户列表参数

const queryParams = ref({
    appId: store.getters["user/getAppId"],
    orgId: undefined,
    type: "SYSTEM",
    page: 1,
    size: 20
});
//表单对象
const formState = ref({
    id: 0,
    appId: store.getters["user/getAppId"],
    orgId: undefined,
    name: "",
    code: "",
    type: "SYSTEM",
    note: "",
    enabled: true
});
const { run: getOrgData, orgTreeData } = useOrgTree();
//modal对象
const userRoleModalRef = ref();
const authPermissionStatus = ref(false);
const confirmAuthPermissionLoading = ref(false);
//当前选择的角色数据
const selectRoleId = ref<number | undefined>();

//第一次就展开所有节点
const expandedKeys = ref<number[]>([]);

const permissionTreeData = ref<any>([]);

//用户列表分页服务
const { data, run, loading } = usePagination<any>(getRoleList, {
    manual: true,
    loadingDelay: 1000
});

//表单对象
const formRef = ref<FormInstance>();

//表格数据
const tableData = computed(() => data?.value?.content ?? []);
//数据条数
const dataCount = computed(() => data?.value?.count ?? 0);

const roleModalStatus = ref(false);
const roleConfirmLoading = ref(false);

const allSelectedNodes = ref<number[]>([]);

// 分配权限
//选中的节点
const permissionCheckedKeys = ref<number[]>([]);
//获取用户列表数据
const getData = () => {
    run(queryParams.value);
};

//表单校验规则
const rules = reactive({
    name: [{ type: "string" as const, required: true, message: "请输入角色名称!" }],
    code: [{ type: "string" as const, required: true, message: "请输入角色编码!" }],
    note: [{ type: "string" as const, required: true, message: "请输入备注!" }]
});
const { validate, resetFields, validateInfos } = useForm(formState, rules);

// 重置表单
const handleReset = () => {
    formState.value = {
        id: 0,
        appId: store.getters["user/getAppId"],
        orgId: undefined,
        name: "",
        code: "",
        type: "SYSTEM",
        note: "",
        enabled: true
    };
};
//添加角色
const handleAddRole = () => {
    resetFields();
    formState.value.appId = queryParams.value.appId;
    // formState.value.orgId = selectIds.value[0];
    roleModalStatus.value = true;
};

//添加角色
const handleDelete = (item: any) => {
    Modal.confirm({
        title: () => '确认删除',
        content: () => '您是否确认删除这条记录',
        onOk() {
            deleteRole(item.id).then((res: any) => {
                message.success("删除成功");
                getData();
            });
        },
        // eslint-disable-next-line @typescript-eslint/no-empty-function
        onCancel() { },
    });
};

//提交添加角色
const handleSubmitRole = () => {
    validate().then(() => {
        roleConfirmLoading.value = true;
        if (formState.value.id === 0) {
            addRole(formState.value)
                .then(() => {
                    message.success("添加成功");
                    roleModalStatus.value = false;
                    getData();
                })
                .finally(() => {
                    roleConfirmLoading.value = false;
                });
        } else {
            updateRole(formState.value)
                .then(() => {
                    message.success("更新成功");
                    roleModalStatus.value = false;
                    getData();
                })
                .finally(() => {
                    roleConfirmLoading.value = false;
                });
        }
    });
};
//编辑角色
const handleEdit = (item: any) => {
    formState.value = { ...item };
    roleModalStatus.value = true;
};
const handleSubmitPermissionAuth = () => {
    if (permissionCheckedKeys.value.length === 0) {
        message.info("请选择权限");
        return;
    }
    confirmAuthPermissionLoading.value = true;
    saveRoleForPermission(selectRoleId.value as number, allSelectedNodes.value)
        .then(() => {
            message.success("权限分配成功");
            authPermissionStatus.value = false;
        })
        .finally(() => {
            confirmAuthPermissionLoading.value = false;
        });
};
const handleShowPermission = (item: any) => {
    selectRoleId.value = item.id;

    getRolePermission(item.id, { type: "MOBILE" }).then((res: any) => {
        permissionCheckedKeys.value = [];
        iterateTreeDataPermission(res);

        permissionTreeData.value = res;
        authPermissionStatus.value = true;
    });
};
//处理数据
const iterateTreeDataPermission = (data: any[]) => {
    data.forEach((item) => {
        item.key = item.id;
        expandedKeys.value.push(item.id);

        console.log(item.checked);

        if (item.children.length > 0) {
            item.checked = item.children.every((child: any) => child.checked == true);
            if (item.checked) {

                permissionCheckedKeys.value?.push(item.id);
            }
            iterateTreeDataPermission(item.children);
        } else {
            if (item.checked) {

                permissionCheckedKeys.value?.push(item.id);
            }
        }
    });
};
//监听复选框
const handleTreeCheck = (keys: number[], info: any) => {
    console.log(info);
    permissionCheckedKeys.value = keys;
    allSelectedNodes.value = permissionCheckedKeys.value.concat(info.halfCheckedKeys);
    // permissionCheckedKeys.value.push();
};
//处理
//监听分页组件变化
const onChange = (page: number, pageSize: number) => {
    queryParams.value.page = page;
    queryParams.value.size = pageSize;
    getData();
};


getData();
getOrgData(store.getters["user/getAppId"]);

</script>
<template>
    <ListContainer @refresh="getData">

        <template #tools>
            <a-button type="primary" @click="handleAddRole">添加角色</a-button>
        </template>
        <template #table="{ height }">
            <div :style="{ height: height + 'px' }">
                <a-table size="small" :columns="columns" :data-source="tableData" :loading="loading" :pagination="false"
                    :scroll="{ x: '100%', y: height - 60 + 'px' }">
                    <template #bodyCell="{ column, record }">
                        <template v-if="column.dataIndex === 'operation'">
                            <a-space :gutter="8">
                                <a-button size="small" type="primary" @click="handleShowPermission(record)">
                                    <span>分配权限</span>
                                </a-button>
                                <a-button size="small" type="ghost" @click="handleEdit(record)">
                                    <edit-outlined />
                                    <span>编辑</span>
                                </a-button>
                                <a-button size="small" danger @click="handleDelete(record)">
                                    <edit-outlined />
                                    <span>删除</span>
                                </a-button>
                            </a-space>
                        </template>
                    </template>
                </a-table>
            </div>
        </template>
        <template #page>
            <a-pagination v-model:current="queryParams.page" class="text-align-right"
                :default-page-size="queryParams.size" show-size-changer show-quick-jumper :total="dataCount"
                :show-total="(total: number) => `共${total}个用户`" @change="onChange" />
        </template>
        <a-modal v-model:visible="roleModalStatus" centered :after-close="handleReset" width="620px"
            :confirm-loading="roleConfirmLoading" :body-style="{ overflowY: 'auto' }"
            :title="formState.id === 0 ? '添加角色' : '编辑角色'" @ok="handleSubmitRole">
            <a-form :model="formState" :label-col="{ span: 4 }">
                <!-- <a-form-item label="所属机构">
                    <a-tree-select v-model:value="formState.orgId" style="width: 100%" show-search
                        :dropdown-style="{ maxHeight: '400px', overflow: 'auto' }" placeholder="请选择所属机构" allow-clear
                        tree-default-expand-all :tree-data="orgTreeData"
                        :field-names="{ label: 'name', value: 'id' }" />
                </a-form-item> -->
                <a-form-item label="角色名称" v-bind="validateInfos.name">
                    <a-input v-model:value="formState.name"></a-input>
                </a-form-item>
                <a-form-item label="角色编码" v-bind="validateInfos.code">
                    <a-input v-model:value="formState.code"></a-input>
                </a-form-item>
                <a-form-item label="备注" v-bind="validateInfos.note">
                    <a-input v-model:value="formState.note"></a-input>
                </a-form-item>
            </a-form>
        </a-modal>
        <a-modal v-model:visible="authPermissionStatus" title="分配权限" centered width="620px"
            :confirm-loading="confirmAuthPermissionLoading" :body-style="{ height: '620px', overflowY: 'auto' }"
            :mask-closable="false" @ok="handleSubmitPermissionAuth">
            <a-tree v-model:checkedKeys="permissionCheckedKeys" v-model:expandedKeys="expandedKeys" show-line checkable
                :tree-data="permissionTreeData" @check="handleTreeCheck" :show-checked-strategy="SHOW_ALL">
                <template #title="{ name }">
                    {{ name }}
                </template>
            </a-tree>
        </a-modal>
    </ListContainer>
</template>
