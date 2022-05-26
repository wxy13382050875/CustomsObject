<script setup lang="ts">
    import { reactive, ref } from "vue";
    import { useRequest } from "vue-request";
    import { FormInstance, message } from "ant-design-vue";
    import {
        permissionList,
        savePermission,
        deletePermission,
        updatePermission
    } from "@/api/permission";
    import { columns } from "@/interface/IPermission";
    import { Form } from "ant-design-vue";
    const useForm = Form.useForm;
    const { run, loading } = useRequest<any>(permissionList, {
        manual: true,
        loadingDelay: 1000
    });
    const queryParams = ref({
        appId: "",
        type: "WEB"
    });
    const formState = ref({
        appId: "",
        parentId: null,
        name: "",
        type: "WEB",
        path: "",
        icon: "",
        sort: 1,
        note: "",
        enabled: true
    });
    const curPermission = ref<any>({});
    //表单对象
    const formRef = ref<FormInstance>();
    const tableData = ref([]);
    const confirmLoading = ref<boolean>(false);
    const addModalStatus = ref(false);
    const editModdalStatus = ref(false);
    const editConfirmLoading = ref<boolean>(false);

    //表单校验规则
    const rules = reactive({
        name: [{ type: "string" as const, required: true, message: "请输入菜单名称!" }],
        path: [{ type: "string" as const, required: true, message: "请输入菜单地址!" }],
        sort: [{ type: "number" as const, required: true, message: "请输入排序!" }]
    });
    const { validate, resetFields, validateInfos } = useForm(formState, rules);
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
                delete item.children;
            }
        });
    };
    const getData = () => {
        if (!queryParams.value.appId) {
            message.info("请选择应用再查询");
            return;
        }
        run(queryParams.value).then((res) => {
            iterateTreeData(res);
            tableData.value = res;
        });
    };

    const handleReset = () => {
        formState.value = {
            appId: "0",
            parentId: null,
            name: "",
            type: "WEB",
            path: "",
            icon: "",
            sort: 1,
            note: "",
            enabled: true
        };
    };
    const handleAdd = () => {
        if (!queryParams.value.appId) {
            message.info("请选择应用后再操作");
            return;
        }
        addModalStatus.value = true;
        resetFields();
        formState.value.appId = queryParams.value.appId;
        formState.value.type =  queryParams.value.type;
        curPermission.value = {};
    };
    //编辑
    const handleEdit = ($event: any, item: any) => {
        $event.stopPropagation();
        formState.value = { ...item };
        editModdalStatus.value = true;
        curPermission.value = {};
    };
    //新增子菜单
    const handleAddSub = ($event: any, item: any) => {
        $event.stopPropagation();
        resetFields();
        curPermission.value = { ...item };
        formState.value.appId = queryParams.value.appId;
        formState.value.type =  queryParams.value.type;
        formState.value.parentId = item.id;
        addModalStatus.value = true;
    };
    //提交新增菜单
    const handleSubmit = () => {
        validate()
            .then(() => {
                confirmLoading.value = true;
                savePermission(formState.value).then(() => {
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
                updatePermission(formState.value).then(() => {
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
    const data = () => {
        return {
            project: "auth-micro-icon",
            password: "heihei",
            fileType: 1004
        };
    };
    const fileList = ref();
    //图标上传
    const handleUploadIconChange = (info: any) => {
        const status = info.file.status;
        const file = info.file;
        if (status === "done") {
            let { response } = file;
            if (response.code === "10000") {
                formState.value.icon = response.data;
            }
        }
    };
</script>
<template>
    <ListContainer>
        <template #form>
            <a-form ref="formRef" :colon="false" :model="queryParams">
                <a-row :gutter="20">
                    <a-col :span="6">
                        <a-form-item label="所属应用" name="appId">
                            <AppSelect v-model:value="queryParams.appId" />
                        </a-form-item>
                    </a-col>
                    <a-col :span="6">
                        <a-form-item label="应用类型" name="type">
                            <a-radio-group v-model:value="queryParams.type">
                                <a-radio value="WEB">WEB</a-radio>
                                <a-radio value="MOBILE">MOBILE</a-radio>
                            </a-radio-group>
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
        </template>
        <template #tools>
            <a-button type="primary" @click="handleAdd">添加菜单</a-button>
        </template>
        <template #table="{ height }">
            <a-table
                :row-key="(record:any) => record.id"
                size="small"
                :columns="columns"
                :data-source="tableData"
                :expand-row-by-click="true"
                :scroll="{ y: height }"
                :pagination="false"
            >
                <template #bodyCell="{ column, record }">
                    <template v-if="column.dataIndex === 'enabled'">
                        {{ record.enabled }}
                    </template>
                    <template v-if="column.dataIndex === 'icon'">
                        <a-image
                            :width="40"
                            :src="record.icon"
                            @click="($event:any)=>$event. $event.stopPropagation()"
                        />
                    </template>
                    <template v-if="column.dataIndex === 'operation'">
                        <a-space :gutter="8">
                            <a-button
                                size="small"
                                type="primary"
                                @click="handleAddSub($event, record)"
                                >添加子菜单</a-button
                            >
                            <a-button size="small" type="ghost" @click="handleEdit($event, record)"
                                >编辑</a-button
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
            :title="!formState.parentId ? '新增菜单' : '新增子菜单'"
            centered
            :after-close="handleReset"
            width="620px"
            :confirm-loading="confirmLoading"
            :body-style="{ overflowY: 'auto' }"
            :mask-closable="false"
            @ok="handleSubmit"
        >
            <a-form :colon="false" :model="formState" :rules="rules" :label-col="{ span: 4 }">
                <a-form-item v-show="JSON.stringify(curPermission) !== '{}'" label="父菜单">
                    {{ curPermission.name }}
                </a-form-item>
                <a-form-item label="菜单名称" v-bind="validateInfos.name">
                    <a-input v-model:value="formState.name" placeholder="请输入菜单名称"></a-input>
                </a-form-item>
                <a-form-item label="菜单地址" v-bind="validateInfos.sort">
                    <a-input v-model:value="formState.path" placeholder="请输入菜单地址"></a-input>
                </a-form-item>
                <a-form-item label="排序" v-bind="validateInfos.path">
                    <a-input-number
                        style="width: 100%"
                        v-model:value="formState.sort"
                        placeholder="请输入排序"
                    ></a-input-number>
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
                <a-form-item v-show="JSON.stringify(curPermission) !== '{}'" label="父菜单">
                    {{ formState.name }}
                </a-form-item>
                <a-form-item label="菜单名称" v-bind="validateInfos.name">
                    <a-input v-model:value="formState.name" placeholder="请输入菜单名称"></a-input>
                </a-form-item>
                <a-form-item label="菜单地址" v-bind="validateInfos.path">
                    <a-input v-model:value="formState.path" placeholder="请输入菜单地址"></a-input>
                </a-form-item>
                <a-form-item label="排序" v-bind="validateInfos.sort">
                    <a-input-number
                        v-model:value="formState.sort"
                        style="width: 100%"
                        placeholder="请输入排序"
                    ></a-input-number>
                </a-form-item>
                <a-form-item label="菜单图标" name="icon">
                    <a-upload
                        @change="handleUploadIconChange"
                        :data="data"
                        action="http://bt-static.yndth.cn/upload"
                        v-model:file-list="fileList"
                        list-type="picture-card"
                        multiple
                        accept=".jpg,.png,.jpeg"
                    >
                        <plus-outlined />
                    </a-upload>
                </a-form-item>
            </a-form>
        </a-modal>
    </ListContainer>
</template>
