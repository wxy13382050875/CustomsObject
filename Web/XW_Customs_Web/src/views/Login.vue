<script setup lang="ts">
import { reactive, computed } from "vue";
import { UserOutlined, LockOutlined } from "@ant-design/icons-vue";
import { login, getCurrentUser } from "@/api/sys";
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

        getCurrentUser().then((data) => {
            console.log(data);
            store.dispatch("user/setAppId", data.appId);
            store.dispatch("user/getAuthorityRouting").then((res: any) => {
                router.push(res[0].path);
            });
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
    <div class="logo-body">
        <div id="login-form-wrapper">
            <div class="login-logo">
                <div>
                    <img :width="95" src="@/assets/icon_logo.png" />
                    <div class="font-title">昆明海关技术中心</div>
                    <div class="font-desc">Kunming Customs Technical Center</div>
                </div>

            </div>
            <div class="login-form-bg">

                <a-form layout="horizontal" size="large" :model="formState" name="normal_login" class="login-form"
                    @finish="onFinish" @finish-failed="onFinishFailed">
                    <a-form-item>
                        <div class="font-title" style="color: #206EEA;text-align: left;">
                            登录<span class="font-desc" style="color: #206EEA;">/ LOG IN</span>
                        </div>
                    </a-form-item>
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
                        <a-button :disabled="disabled" type="primary" shape="round" html-type="submit" class="login-form-button">
                            登录
                        </a-button>
                    </a-form-item>
                    <a-form-item>
                        <div >
                            <img :width="15" src="@/assets/icon_point.png" />
                            如登录遇到问题，请联系管理员
                        </div>
                    </a-form-item>
                </a-form>
            </div>

        </div>
        <div class="login-bg-masking">

        </div>
    </div>

</template>
<style>
#login-form-wrapper {
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    background: linear-gradient(180deg, #206EEA 0%, #175ECE 100%);
}

#login-form-wrapper .login-form {
    width: 420px;

}

#login-form-wrapper .login-form-button {
    width: 100%;
}

.login-logo {
    display: flex;
    width: 360px;
    height: 320px;
    justify-content: center;
    align-items: center;
    background: #175ECE;
    text-align: center;
    color: #fff;
}

.font-title {
    font-size: 29px;
    font-family: Source Han Serif CN-Bold, Source Han Serif CN;
    font-weight: bold;

    margin-top: 5px;
}

.font-desc {
    font-size: 10px;
    font-family: Source Han Sans CN-Regular, Source Han Sans CN;
}

.login-form-bg {

    display: flex;
    width: 360px;
    height: 320px;
    justify-content: center;
    align-items: center;
    background: #F1F8FF;
    text-align: center;
    padding: 45px;
}

.ant-form-item {
    margin-bottom: 15px !important;
}

.login-bg-masking {
    background: url("@/assets/icon_logo_masking.png");
    left: 0;
    right: 0;
    bottom: 0;
    height: 163px;
    position: fixed;
    background-size: 100% 100%;
}
.logo-body{
    position: relative;
    width: 100%;
    height: 100%;
}
.ant-btn-primary{
    background: #00C8FF !important;
    border-color: #00C8FF !important;
}
</style>
