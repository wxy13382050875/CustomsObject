<script setup lang="ts">
import { reactive, ref, shallowRef } from "vue";
import { useRequest } from "vue-request";
import { FormInstance, message } from "ant-design-vue";
import {
    orgList,
    orgPermissionList,
    orgSave,
    orgUpdate,
    orgAssignPermissions,
    deleteOrg
} from "@/api/org";
import { uploadFile } from "@/api/system";
import { columns } from "@/interface/IOrg";
import { Form } from "ant-design-vue";
import { store } from "@/store";
import "@wangeditor/editor/dist/css/style.css"; // 引入 css
import { Editor, Toolbar } from "@wangeditor/editor-for-vue";
//类型定义
type InsertFnType = (url: string, alt?: string, href?: string) => void;

const useForm = Form.useForm;
const { run, loading } = useRequest<any>(orgList, {
    manual: true,
    loadingDelay: 1000
});
const queryParams = ref({
    appId: store.getters["user/getAppId"]
});
const formState = ref({
    appId: store.getters["user/getAppId"],
    parentId: null,
    name: "",
    code: "",
    sort: 1,
    note: null,
    enabled: true,
    contents: ""
});

//编辑器配置
const mode = ref("default");
const editorRef = shallowRef();
const toolbarConfig = {};
const editorConfig = {
    placeholder: "请输入内容...",
    MENU_CONF: {} as any
};

editorConfig.MENU_CONF["uploadImage"] = {
    async customUpload(file: File, insertFn: InsertFnType) {
        // const loadingInstance = ElLoading.service({
        // 	fullscreen: true,
        // 	text: "正在上传图片"
        // });
        const rs = await uploadFile(file);
        // loadingInstance.close();
        insertFn(rs.data.data);
    }
};

const handleCreated = (editor: any) => {
    editorRef.value = editor;
};

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
    deleteOrg(key).then(() => {
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
        enabled: true,
        contents: ""
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
    orgPermissionList(item.id, { type: "MOBILE" }).then((res: any) => {
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
            <a-button type="primary" @click="
                () => {
                    addModalStatus = true;
                    curOrg = {};
                }
            ">添加机构</a-button>
        </template>
        <template #table="{ height }">
            <a-table :row-key="(record: any) => record.id" size="small" :indent-size="42" :columns="columns"
                :data-source="tableData" :pagination="false" :scroll="{ y: height }" :expand-row-by-click="true">
                <template #bodyCell="{ column, record }">
                    <template v-if="column.dataIndex === 'enabled'">
                        {{ record.enabled }}
                    </template>
                    <template v-if="column.dataIndex === 'operation'">
                        <a-space :gutter="8">
                            <a-button size="small" type="primary" @click="handleAddSub($event, record)">添加子机构</a-button>
                            <a-button size="small" type="ghost" @click="handleEdit($event, record)">编辑</a-button>
                            <a-button size="small" type="primary" @click="handleAuthPermission($event, record)">分配权限
                            </a-button>
                            <a-popconfirm v-if="!record.children" placement="left" :title="`是否确认删除${record.name}?`"
                                @confirm="handleDelete(record.id)">
                                <a-button size="small" type="danger">删除</a-button>
                            </a-popconfirm>
                        </a-space>
                    </template>
                </template>
            </a-table>
        </template>
        <a-modal v-model:visible="addModalStatus" :title="!formState.parentId ? '新增机构' : '新增子机构'" centered
            :after-close="handleReset" width="620px" :confirm-loading="confirmLoading"
            :body-style="{ overflowY: 'auto' }" :mask-closable="false" @ok="handleSubmit">
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
                    <a-input-number v-model:value="formState.sort" style="width: 100%"></a-input-number>
                </a-form-item>
                <a-form-item label="备注" name="note">
                    <a-input v-model:value="formState.note" placeholder="请输入备注"></a-input>
                </a-form-item>
                <!-- <a-form-item label="机构介绍" name="contents">
                    <div class="editor-wrapper">
                        <Toolbar style="border-bottom: 1px solid #ccc; border-top: 1px solid #ccc" :editor="editorRef"
                            :defaultConfig="toolbarConfig" :mode="mode" />
                        <Editor style="height: 300px" class="editor-obj" v-model="formState.contents"
                            :defaultConfig="editorConfig" :mode="mode" @onCreated="handleCreated" />
                    </div>
                </a-form-item> -->
            </a-form>
        </a-modal>
        <a-modal v-model:visible="editModdalStatus" title="编辑菜单" :after-close="handleReset" centered width="620px"
            :confirm-loading="editConfirmLoading" :body-style="{ overflowY: 'auto' }" :mask-closable="false"
            @ok="handleSubmitUpdate">
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
                    <a-input-number v-model:value="formState.sort" style="width: 100%"></a-input-number>
                </a-form-item>
                <a-form-item label="备注" name="note">
                    <a-input v-model:value="formState.note" placeholder="请输入备注"></a-input>
                </a-form-item>
                <!-- <a-form-item label="机构介绍" name="contents">
                    <div class="editor-wrapper">
                        <Toolbar style="border-bottom: 1px solid #ccc; border-top: 1px solid #ccc" :editor="editorRef"
                            :defaultConfig="toolbarConfig" :mode="mode" />
                        <Editor style="height:300px" class="editor-obj" v-model="formState.contents"
                            :defaultConfig="editorConfig" :mode="mode" @onCreated="handleCreated" />
                    </div>
                </a-form-item> -->

            </a-form>
        </a-modal>
        <a-modal v-model:visible="authPermissionStatus" title="分配权限" centered width="620px"
            :confirm-loading="confirmAuthPermissionLoading" :body-style="{ height: '620px', overflowY: 'auto' }"
            :mask-closable="false" @ok="handleSubmitPermissionAuth">
            <a-tree v-model:checkedKeys="checkedKeys" v-model:expandedKeys="expandedKeys" show-line checkable
                :tree-data="permissionTreeData" @check="handleTreeCheck">
                <template #title="{ name }">
                    {{ name }}
                </template>
            </a-tree>
        </a-modal>
    </ListContainer>
</template>
<style lang="scss">
.editor-header {
	display: flex;
	align-items: center;
	padding: 0 20px;
	height: 64px;
	background-color: #fff;

	.title {
		flex: 1 1 auto;
		.title-input {
			width: 100%;
			margin: 0;
			padding: 0;
			font-size: 24px;
			font-weight: 500;
			color: #1d2129;
			border: none;
			outline: none;
		}
	}
}

.w-e-text-container {
	background-color: #f8f9fa;
}
.editor {
	display: flex;

	.preview,
	.editor-obj {
		width: 500%;
	}
}

.publish-wrapper {
	display: flex;
	align-items: center;
}
.el-popper {
	padding: 0 !important;
}
.publish {
	.item {
		padding: 0 24px;
	}
	.btn {
		display: flex;
		justify-content: flex-end;
		padding: 0 24px 24px;
	}
}
</style>