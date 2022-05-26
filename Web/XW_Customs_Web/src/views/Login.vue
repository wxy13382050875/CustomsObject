<script setup lang="ts">
    import { reactive, computed } from "vue";
    import { UserOutlined, LockOutlined } from "@ant-design/icons-vue";
    import { login } from "@/api/sys";
    import { useStore } from "@/store";
    import { useRouter } from "vue-router";

    interface FormState {
        username: string;
        password: string;
    }

    const store = useStore();
    const router = useRouter();
    const formState = reactive<FormState>({
        username: "",
        password: ""
    });

    const onFinish = () => {
        login(formState).then((res: string) => {
            store.dispatch("user/setToken", res);
            store.dispatch("user/getAuthorityRouting").then((res: any) => {
                router.push(res[0].path);
            });
        });
    };

    const onFinishFailed = (errorInfo: any) => {
        console.log("Failed:", errorInfo);
    };

    const disabled = computed(() => {
        return !(formState.username && formState.password);
    });
</script>
<template>
    <div id="login-form-wrapper">
        <a-form
            :label-col="{ span: 2 }"
            :wrapper-col="{ span: 22 }"
            size="large"
            :model="formState"
            name="normal_login"
            class="login-form"
            @finish="onFinish"
            @finish-failed="onFinishFailed"
        >
            <a-form-item name="username" :rules="[{ required: true, message: '请输入用户名!' }]">
                <a-input v-model:value="formState.username" placeholder="请输入用户名">
                    <template #prefix>
                        <UserOutlined class="site-form-item-icon" />
                    </template>
                </a-input>
            </a-form-item>

            <a-form-item name="password" :rules="[{ required: true, message: '请输入密码' }]">
                <a-input-password v-model:value="formState.password" placeholder="请输入密码">
                    <template #prefix>
                        <LockOutlined class="site-form-item-icon" />
                    </template>
                </a-input-password>
            </a-form-item>
            <a-form-item>
                <a-button
                    :disabled="disabled"
                    type="primary"
                    html-type="submit"
                    class="login-form-button"
                >
                    登录
                </a-button>
            </a-form-item>
        </a-form>
    </div>
</template>
<style>
    #login-form-wrapper {
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    #login-form-wrapper .login-form {
        width: 420px;
    }

    #login-form-wrapper .login-form-button {
        width: 100%;
    }
</style>
