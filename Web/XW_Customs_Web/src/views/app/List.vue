<script setup lang="ts">
    import { ref } from "vue";
    import { message } from "ant-design-vue";
    import type { FormInstance } from "ant-design-vue";
    import { appList, appSave, appUpdate } from "@/api/app";
    import type { IApp } from "@/api/app";

    const dataList = ref<IApp[]>();
    const formRef = ref<FormInstance>();
    const formState = ref<IApp>({
        name: "",
        code: "",
        note: ""
    });

    const getData = () => {
        appList().then((data) => {
            dataList.value = data.content;
        });
    };
    getData();

    const visible = ref(false);
    const handleAdd = () => {
        formRef.value?.resetFields();
        formState.value.id = undefined;
        formState.value.name = "";
        formState.value.note = "";
        formState.value.code = "";

        visible.value = true;
    };
    const handleEdit = (item: IApp) => {
        formRef.value?.resetFields();
        formState.value = { ...item };
        visible.value = true;
    };
    //确定提交
    const handleOnOk = () => {
        formRef.value?.validateFields().then(() => {
            if (!formState.value.id) {
                //新增
                appSave(formState.value).then(() => {
                    message.success("新增应用成功");
                    visible.value = false;
                    getData();
                });
            } else {
                //更新
                appUpdate(formState.value).then(() => {
                    message.success("编辑应用成功");
                    visible.value = false;
                    getData();
                });
            }
        });
    };
</script>
<template>
    <ListContainer>
        <div class="h-full">
            <a-row :gutter="[18, 18]">
                <a-col :span="6">
                    <a-button class="new-btn h-full" type="dashed" @click="handleAdd">
                        <plus-outlined />
                        <span>添加应用</span>
                    </a-button>
                </a-col>
                <a-col :span="6" v-for="item in dataList" :key="item.id">
                    <a-card hoverable>
                        <template #cover>
                            <div :style="{ height: 100 + 'px', backgroundColor: '' }"></div>
                        </template>
                        <a-card-meta :title="item.name" :description="item.note">
                            <template #avatar>
                                <a-avatar style="background-color: #f56a00">
                                    {{ item.name.substr(0, 1) }}
                                </a-avatar>
                            </template>
                        </a-card-meta>
                        <template #actions>
                            <setting-outlined key="setting" />
                            <edit-outlined key="edit" @click="handleEdit(item)" />

                            <a-dropdown :trigger="['click']">
                                <a class="ant-dropdown-link" @click.prevent>
                                    <ellipsis-outlined key="ellipsis" />
                                </a>
                                <template #overlay>
                                    <a-menu>
                                        <a-menu-item key="0">
                                            <router-link
                                                :to="{
                                                    path: '/permission',
                                                    query: { appId: item.id }
                                                }"
                                            >
                                                权限管理
                                            </router-link>
                                        </a-menu-item>
                                        <a-menu-item key="1">
                                            <router-link
                                                :to="{
                                                    path: '/permission',
                                                    query: { appId: item.id }
                                                }"
                                            >
                                                角色管理
                                            </router-link>
                                        </a-menu-item>
                                        <a-menu-divider />
                                        <a-menu-item key="3">
                                            <router-link
                                                :to="{
                                                    path: '/permission',
                                                    query: { appId: item.id }
                                                }"
                                            >
                                                机构管理
                                            </router-link>
                                        </a-menu-item>
                                    </a-menu>
                                </template>
                            </a-dropdown>
                        </template>
                    </a-card>
                </a-col>
            </a-row>
        </div>
        <a-modal
            v-model:visible="visible"
            :title="!formState.id ? '新增应用' : '编辑应用'"
            centered
            @ok="handleOnOk"
        >
            <a-form :model="formState" ref="formRef" :colon="false" :label-col="{ span: 4 }">
                <a-form-item
                    label="应用名称"
                    name="name"
                    :rules="[{ required: true, message: '请输入应用名称' }]"
                >
                    <a-input v-model:value="formState.name" placeholder="请输入应用名称"></a-input>
                </a-form-item>
                <a-form-item
                    label="应用CODE"
                    name="code"
                    :rules="[{ required: true, message: '请输入应用名称' }]"
                >
                    <a-input v-model:value="formState.code" placeholder="请输入应用CODE"></a-input>
                </a-form-item>
                <a-form-item
                    label="描述"
                    name="note"
                    :rules="[{ required: true, message: '请输入描' }]"
                >
                    <a-input v-model:value="formState.note" placeholder="请输入描述"></a-input>
                </a-form-item>
            </a-form>
        </a-modal>
    </ListContainer>
</template>
<style lang="scss" scoped>
    .new-btn {
        width: 100%;
        // height: 201px;
        color: rgba(0, 0, 0, 0.45);
        background-color: #fff;
        border-color: #d9d9d9;
    }
</style>
