<script setup lang="ts">
    import { reactive, ref } from "vue";
    import { useRequest } from "vue-request";
    import { FormInstance, message } from "ant-design-vue";
    import { deletePermission } from "@/api/permission";
    import {
        orgList,
        orgPermissionList,
        orgSave,
        orgUpdate,
        orgAssignPermissions
    } from "@/api/org";
    import { columns } from "@/interface/IOrg";
    import { Form } from "ant-design-vue";
import { store } from "@/store";

    const useForm = Form.useForm;
    const { run, loading } = useRequest<any>(orgList, {
        manual: true,
        loadingDelay: 1000
    });
    const queryParams = ref({
        appId: store.getters["user/getAppId"]
    });
    const formState = ref({
        appId:store.getters["user/getAppId"],
        parentId: null,
        name: "",
        code: "",
        sort: 1,
        note: null,
        enabled: true
    });
    const curOrg = ref<any>({});
    //表单对象
    const formRef = ref<FormInstance>();
    const tableData = ref([]);
    const confirmLoading = ref<boolean>(false);
    const addModalStatus = ref(false);
    const editModdalStatus = ref(false);
    const editConfirmLoading = ref<boolean>(false);

    //表单校验规则
    const rules = reactive({
        //appId: [{ type: "string" as const, required: true, message: "请选择应用!" }],
        name: [{ type: "string" as const, required: true, message: "请输入机构名称!" }],
        code: [{ type: "string" as const, required: true, message: "请输入机构编码!" }]
    });
    const { validate, validateInfos } = useForm(formState, rules);
    //删除
    const handleDelete = (key: number) => {
        deletePermission(key).then(() => {
            getData();
        });
    };
    //处理数据
    const iterateTreeData = (data: any[]) => {
        data.forEach((item) => {
            if (item.children.length > 0) {
                iterateTreeData(item.children);
            } else {
                // item.children = undefined;
                delete item.children;
            }
        });
    };
    //选中的节点
    const checkedKeys = ref<number[]>([]);
    //第一次就展开所有节点
    const expandedKeys = ref<number[]>([]);
    //处理数据
    const iterateTreeDataPermission = (data: any[]) => {
        data.forEach((item) => {
            item.key = item.id;
            expandedKeys.value.push(item.id);
            if (item.checked) {
                checkedKeys.value?.push(item.id);
            }
            if (item.children.length > 0) {
                iterateTreeDataPermission(item.children);
            }
        });
    };
    const getData = () => {
        run(queryParams.value.appId).then((res) => {
            iterateTreeData(res);
            tableData.value = res;
        });
    };
    getData();

    //重置表单
    const resetForm = () => {
        formRef.value?.resetFields();
    };
    const handleReset = () => {
        formState.value = {
            appId: store.getters["user/getAppId"],
            parentId: null,
            name: "",
            code: "",
            sort: 1,
            note: null,
            enabled: true
        };
    };
    //编辑
    const handleEdit = ($event: any, item: any) => {
        formState.value = { ...item };
        curOrg.value = {};
        editModdalStatus.value = true;
        $event.stopPropagation();
    };
    //新增子菜单
    const handleAddSub = ($event: any, item: any) => {
        curOrg.value = { ...item };
        formState.value.parentId = item.id;
        formState.value.appId = queryParams.value.appId;
        addModalStatus.value = true;
        $event.stopPropagation();
    };
    //提交新增菜单
    const handleSubmit = () => {
        validate()
            .then(() => {
                confirmLoading.value = true;
                formState.value.appId = queryParams.value.appId;
                orgSave(formState.value).then(() => {
                    message.success("新增成功");
                    confirmLoading.value = false;
                    addModalStatus.value = false;
                    getData();
                });
            })
            .catch((err) => {
                console.log("error", err);
            });
    };
    // 提交更新
    const handleSubmitUpdate = () => {
        validate()
            .then(() => {
                editConfirmLoading.value = true;
                formState.value.appId = queryParams.value.appId;
                orgUpdate(formState.value).then(() => {
                    message.success("更新成功");
                    editConfirmLoading.value = false;
                    editModdalStatus.value = false;
                    getData();
                });
            })
            .catch((err) => {
                console.log("error", err);
            });
    };
    const permissionTreeData = ref([]);
    const authPermissionStatus = ref(false);
    const confirmAuthPermissionLoading = ref(false);
    const handleAuthPermission = ($event: any, item: any) => {
        $event.stopPropagation();
        curOrg.value = item;
        orgPermissionList(item.id, { type: "WEB" }).then((res: any) => {
            checkedKeys.value = [];
            iterateTreeDataPermission(res);
            permissionTreeData.value = res;
            authPermissionStatus.value = true;
        });
    };
    //监听复选框
    const handleTreeCheck = (keys: number[]) => {
        checkedKeys.value = keys;
    };
    const handleSubmitPermissionAuth = () => {
        if (checkedKeys.value.length === 0) {
            message.info("请选择权限");
            return;
        }
        confirmAuthPermissionLoading.value = true;
        orgAssignPermissions(curOrg.value.id, checkedKeys.value)
            .then(() => {
                authPermissionStatus.value = false;
                message.success("权限分配成功");
            })
            .finally(() => {
                confirmAuthPermissionLoading.value = false;
            });
    };
</script>
<template>
    <ListContainer>
        <!-- <template #form>
            <a-form ref="formRef" :colon="false" :model="queryParams">
                <a-row :gutter="20">
                    <a-col :span="6">
                        <a-form-item label="所属应用" name="appId">
                            <AppSelect v-model:value="queryParams.appId" />
                        </a-form-item>
                    </a-col>
                    <a-col :span="6">
                        <a-space align="end">
                            <a-button type="primary" :loading="loading" @click="getData">
                                <search-outlined />
                                <span>查询</span>
                            </a-button>
                        </a-space>
                    </a-col>
                </a-row>
            </a-form>
        </template> -->
        <template #tools>
            <a-button
                type="primary"
                @click="
                    () => {
                        addModalStatus = true;
                        curOrg = {};
                    }
                "
                >添加机构</a-button
            >
        </template>
        <template #table="{ height }">
            <a-table
                :row-key="(record:any) => record.id"
                size="small"
                :indent-size="42"
                :columns="columns"
                :data-source="tableData"
                :pagination="false"
                :scroll="{ y: height }"
                :expand-row-by-click="true"
            >
                <template #bodyCell="{ column, record }">
                    <template v-if="column.dataIndex === 'enabled'">
                        {{ record.enabled }}
                    </template>
                    <template v-if="column.dataIndex === 'operation'">
                        <a-space :gutter="8">
                            <a-button
                                size="small"
                                type="primary"
                                @click="handleAddSub($event, record)"
                                >添加子机构</a-button
                            >
                            <a-button size="small" type="ghost" @click="handleEdit($event, record)"
                                >编辑</a-button
                            >
                            <a-button
                                size="small"
                                type="primary"
                                @click="handleAuthPermission($event, record)"
                                >分配权限</a-button
                            >
                            <a-popconfirm
                                v-if="!record.children"
                                placement="left"
                                :title="`是否确认删除${record.name}?`"
                                @confirm="handleDelete(record.id)"
                            >
                                <a-button size="small" type="danger">删除</a-button>
                            </a-popconfirm>
                        </a-space>
                    </template>
                </template>
            </a-table>
        </template>
        <a-modal
            v-model:visible="addModalStatus"
            :title="!formState.parentId ? '新增机构' : '新增子机构'"
            centered
            :after-close="handleReset"
            width="620px"
            :confirm-loading="confirmLoading"
            :body-style="{ overflowY: 'auto' }"
            :mask-closable="false"
            @ok="handleSubmit"
        >
            <a-form :colon="false" :model="formState" :rules="rules" :label-col="{ span: 4 }">
                <a-form-item v-show="JSON.stringify(curOrg) !== '{}'" label="父机构">
                    {{ curOrg.name }}
                </a-form-item>
                <a-form-item label="机构名称" v-bind="validateInfos.name">
                    <a-input v-model:value="formState.name" placeholder="请输入机构名称"></a-input>
                </a-form-item>
                <a-form-item label="机构编码" v-bind="validateInfos.code">
                    <a-input v-model:value="formState.code" placeholder="请输入机构编码"></a-input>
                </a-form-item>
                <a-form-item label="排序" v-bind="validateInfos.sort">
                    <a-input-number
                        v-model:value="formState.sort"
                        style="width: 100%"
                    ></a-input-number>
                </a-form-item>
                <a-form-item label="备注" name="note">
                    <a-input v-model:value="formState.note" placeholder="请输入备注"></a-input>
                </a-form-item>
            </a-form>
        </a-modal>
        <a-modal
            v-model:visible="editModdalStatus"
            title="编辑菜单"
            :after-close="handleReset"
            centered
            width="620px"
            :confirm-loading="editConfirmLoading"
            :body-style="{ overflowY: 'auto' }"
            :mask-closable="false"
            @ok="handleSubmitUpdate"
        >
            <a-form :colon="false" :model="formState" :rules="rules" :label-col="{ span: 4 }">
                <a-form-item v-show="JSON.stringify(curOrg) !== '{}'" label="父机构">
                    {{ curOrg.name }}
                </a-form-item>
                <a-form-item label="机构名称" v-bind="validateInfos.name">
                    <a-input v-model:value="formState.name" placeholder="请输入机构名称"></a-input>
                </a-form-item>
                <a-form-item label="机构编码" v-bind="validateInfos.code">
                    <a-input v-model:value="formState.code" placeholder="请输入机构编码"></a-input>
                </a-form-item>
                <a-form-item label="排序" v-bind="validateInfos.sort">
                    <a-input-number
                        v-model:value="formState.sort"
                        style="width: 100%"
                    ></a-input-number>
                </a-form-item>
                <a-form-item label="备注" name="note">
                    <a-input v-model:value="formState.note" placeholder="请输入备注"></a-input>
                </a-form-item>
            </a-form>
        </a-modal>
        <a-modal
            v-model:visible="authPermissionStatus"
            title="分配权限"
            centered
            width="620px"
            :confirm-loading="confirmAuthPermissionLoading"
            :body-style="{ height: '620px', overflowY: 'auto' }"
            :mask-closable="false"
            @ok="handleSubmitPermissionAuth"
        >
            <a-tree
                v-model:checkedKeys="checkedKeys"
                v-model:expandedKeys="expandedKeys"
                show-line
                checkable
                :tree-data="permissionTreeData"
                @check="handleTreeCheck"
            >
                <template #title="{ name }">
                    {{ name }}
                </template>
            </a-tree>
        </a-modal>
    </ListContainer>
</template>
