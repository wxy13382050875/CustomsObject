<script setup lang="ts">
    import { reactive, ref } from "vue";
    import { FormInstance, message } from "ant-design-vue";
    import { IUser } from "@/interface/IUser";
    import { saveUserInfo } from "@/api/user";
    import { useOrgTree, useValidate } from "@/utils/hooks";

    const formRef = ref<FormInstance>();
    const showContainerRef = ref();
    const formState = reactive<IUser>({
        appId: undefined,
        code: "",
        username: "",
        password: "",
        trueName: "",
        alias: "",
        pic: "",
        phone: undefined,
        email: "",
        sex: "",
        papersType: undefined,
        papersNo: "",
        type: "MANAGE",
        orgIds: [],
        roleIds: []
    });
    const { run: getOrgData, orgTreeData } = useOrgTree();
    const { validatorIdcard, validatorPhone, validatorEmail } = useValidate();
    const rules = reactive({
        appId: [{ type: "number" as const, required: true, message: "请选择应用!" }],
        username: [{ type: "string" as const, required: true, message: "请输入用户名!" }],
        password: [{ type: "string" as const, required: true, message: "请输入密码!" }],
        phone: [
            // { type: "number" as const, required: true, message: "请输入手机号!" },
            {
                required: true,
                validator: validatorPhone
            }
        ],
        trueName: [{ type: "string" as const, required: true, message: "请输入真实姓名!" }],
        papersType: [{ type: "string" as const, required: true, message: "请选择证件类型!" }],
        papersNo: [
            // { type: "string" as const, required: true, message: "请输入证件号码!" },
            {
                required: true,
                validator: validatorIdcard
            }
        ],
        email: [
            // { type: "string" as const, required: true, message: "请输入邮箱!" },
            {
                required: true,
                validator: validatorEmail
            }
        ],
        orgIds: [{ type: "array" as const, required: true, message: "请选择所属机构!" }]
    });

    //验证通过 提交表单数据
    const onFinish = () => {
        saveUserInfo(formState).then(() => {
            message.success("添加成功");
            showContainerRef.value.refresh();
        });
    };

    const onFinishFailed = (errorInfo: unknown) => {
        console.log("Failed:", errorInfo);
    };
    const handleValidate = (...args: any[]) => {
        console.log(args);
    };
    const handleAppIdSelectChange = (appId: string) => {
        if (!appId) {
            return;
        }
        getOrgData(appId);
    };
    //重置表单
    const resetForm = () => {
        formRef.value?.resetFields();
    };
</script>
<template>
    <ShowContainer ref="showContainerRef" title="新增用户">
        <a-form
            ref="formRef"
            :colon="false"
            :model="formState"
            :rules="rules"
            name="basic"
            :label-col="{ span: 2 }"
            :wrapper-col="{ span: 8 }"
            autocomplete="off"
            allow-clear
            @finish="onFinish"
            @finish-failed="onFinishFailed"
            @validate="handleValidate"
        >
            <a-form-item label="所属应用" name="appId">
                <AppSelect
                    @change="handleAppIdSelectChange"
                    placeholder="请选择所属应用"
                    v-model:value="formState.appId"
                />
            </a-form-item>
            <a-form-item label="所属机构" name="orgIds">
                <a-tree-select
                    v-model:value="formState.orgIds"
                    has-feedback
                    style="width: 100%"
                    show-search
                    :dropdown-style="{ maxHeight: '400px', overflow: 'auto' }"
                    placeholder="请选择所属机构"
                    allow-clear
                    tree-default-expand-all
                    multiple
                    :tree-data="orgTreeData"
                    :field-names="{ label: 'name', value: 'id' }"
                />
            </a-form-item>
            <a-form-item has-feedback label="用户名" name="username">
                <a-input v-model:value="formState.username" placeholder="请输入用户名" />
            </a-form-item>
            <a-form-item has-feedback label="密码" name="password">
                <a-input
                    v-model:value="formState.password"
                    type="password"
                    placeholder="请输入密码"
                />
            </a-form-item>
            <a-form-item has-feedback label="真实姓名" name="trueName">
                <a-input v-model:value="formState.trueName" placeholder="请输入真实姓名" />
            </a-form-item>
            <a-form-item has-feedback label="手机号" name="phone">
                <a-input-number
                    v-model:value="formState.phone"
                    style="width: 100%"
                    placeholder="请输入手机号"
                />
            </a-form-item>
            <a-form-item has-feedback label="邮箱" name="email">
                <a-input v-model:value="formState.email" placeholder="请输入邮箱" />
            </a-form-item>
            <a-form-item has-feedback label="证件类型" name="papersType">
                <a-select v-model:value="formState.papersType" placeholder="请选择证件类型">
                    <a-select-option key="1" value="身份证"></a-select-option>
                </a-select>
            </a-form-item>
            <a-form-item has-feedback label="证件号码" name="papersNo">
                <a-input v-model:value="formState.papersNo" placeholder="请输入证件号码" />
            </a-form-item>
            <a-form-item :wrapper-col="{ span: 14, offset: 2 }">
                <a-button type="primary" html-type="submit">提交</a-button>
                <a-button style="margin-left: 10px" @click="resetForm">重置</a-button>
            </a-form-item>
        </a-form>
    </ShowContainer>
</template>
