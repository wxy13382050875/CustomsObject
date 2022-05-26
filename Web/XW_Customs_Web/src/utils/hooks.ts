import { ref } from "vue";
import { orgList } from "@/api/org";
const useOrgTree = () => {
    const orgTreeData = ref<any>();
    const run = (appId: string) => {
        orgList(appId).then((res: any) => {
            orgTreeData.value = res;
        });
    };
    return { run, orgTreeData };
};

const useValidate = () => {
    const validatorPhone = (rule: any, value: string) => {
        // 如果为空值，就抛出错误
        if (!value) {
            return Promise.reject("请输入手机号");
        } else {
            // 正则判断手机号格式的格式，正则判断失败抛出错误，否则直接callback()
            if (!/^1[2-9]\d{9}$/.test(value)) {
                return Promise.reject("手机号格式不正确");
            } else {
                return Promise.resolve();
            }
        }
    };
    const validatorIdcard = (rule: any, value: string) => {
        // 如果为空值，就抛出错误
        if (!value) {
            return Promise.reject("请输入身份证号码");
        } else {
            // 正则判断手机号格式的格式，正则判断失败抛出错误，否则直接callback()
            if (!/(^\d{18}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(value)) {
                return Promise.reject("身份证格式不正确!");
            } else {
                return Promise.resolve();
            }
        }
    };
    const validatorEmail = (rule: any, value: string) => {
        const reg = /^([a-zA-Z]|[0-9])(\w|\\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
        if (!value) {
            return Promise.reject("请输入邮箱");
        }
        if (!reg.test(value)) {
            return Promise.reject("邮箱格式不正确!");
        } else {
            return Promise.resolve();
        }
    };
    return {
        validatorPhone,
        validatorIdcard,
        validatorEmail
    };
};

export { useOrgTree, useValidate };
