<script setup lang="ts">
    import { computed, reactive, ref } from "vue";
    import { FormInstance } from "ant-design-vue";
    import { usePagination } from "vue-request";
    import { useRouter } from "vue-router";
    import { columns } from "@/interface/IUser";
    import { userList } from "@/api/user";
    import { useOrgTree } from "@/utils/hooks";

    //组件
    import UserRoleModal from "./component/UserRoleModal.vue";

    //定义参数类型
    interface IQueryParams {
        appId: number | string | undefined;
        orgId: number | string | undefined;
        page: number;
        size: number;
    }
    //查询用户列表参数
    const queryParams = reactive<IQueryParams>({
        appId: undefined,
        orgId: undefined,
        page: 1,
        size: 1
    });
    const router = useRouter();
    const { run: getOrgData, orgTreeData } = useOrgTree();

    //modal对象
    const userRoleModalRef = ref();
    //用户列表分页服务
    const { data, run, loading } = usePagination<any>(userList, {
        manual: true,
        loadingDelay: 1000
    });

    //表单对象
    const formRef = ref<FormInstance>();

    //表格数据
    const tableData = computed(() => data?.value?.content ?? []);
    //数据条数
    const dataCount = computed(() => data?.value?.count ?? 0);

    const handleQuery = () => {
        queryParams.page = 1;
        getData();
    };

    const handleAppIdSelectChange = (value: string) => {
        if (!value) {
            orgTreeData.value = [];
            return;
        }
        queryParams.appId = value;
        getOrgData(value);
    };

    //获取用户列表数据
    const getData = () => {
        run(queryParams);
    };
    getData();

    //分配角色
    const handleAssignRole = (item: any) => {
        console.log(item);
        userRoleModalRef.value.show();
        userRoleModalRef.value.getData(item.id);
    };

    //监听分页组件变化
    const onChange = (page: number, pageSize: number) => {
        queryParams.page = page;
        queryParams.size = pageSize;
        getData();
    };
    const resetFiled = () => {
        formRef.value?.resetFields();
    };
</script>
<template>
    <ListContainer @refresh="getData">
        <template #form>
            <a-form
                ref="formRef"
                :label-col="{ span: 6 }"
                :wrapper-col="{ span: 18 }"
                :colon="false"
                :model="queryParams"
            >
                <a-row :gutter="18">
                    <a-col :span="6">
                        <a-form-item label="所属应用" name="appId">
                            <AppSelect
                                @change="handleAppIdSelectChange"
                                v-model:value="queryParams.appId"
                            />
                            <!-- <a-select
                                v-model:value="queryParams.appId"
                                allow-clear
                                placeholder="请选择所属应用"
                                @change="handleAppIdSelectChange"
                            >
                                <a-select-option key="1" value="1">昆明技术中心</a-select-option>
                            </a-select> -->
                        </a-form-item>
                    </a-col>
                    <a-col :span="6">
                        <a-form-item label="所属机构" name="orgId">
                            <a-tree-select
                                v-model:value="queryParams.orgId"
                                style="width: 100%"
                                show-search
                                :dropdown-style="{ maxHeight: '400px', overflow: 'auto' }"
                                placeholder="请选择所属机构"
                                allow-clear
                                tree-default-expand-all
                                :tree-data="orgTreeData"
                                :field-names="{ label: 'name', value: 'id' }"
                            />
                        </a-form-item>
                    </a-col>
                    <a-col :span="6">
                        <a-space>
                            <a-button type="primary" @click="handleQuery">查询</a-button>
                            <a-button @click="resetFiled">清除</a-button>
                        </a-space>
                    </a-col>
                </a-row>
            </a-form>
        </template>
        <template #tools>
            <a-button
                type="primary"
                @click="
                    () => {
                        router.push('/user/add');
                    }
                "
                >添加用户</a-button
            >
        </template>
        <template #table="{ height }">
            <div :style="{ height: height + 'px' }">
                <a-table
                    size="small"
                    :columns="columns"
                    :data-source="tableData"
                    :loading="loading"
                    :pagination="false"
                    :scroll="{ x: '100%', y: height - 60 + 'px' }"
                >
                    <template #bodyCell="{ column, record }">
                        <template v-if="column.dataIndex === 'operation'">
                            <a-space :gutter="8">
                                <a-button
                                    size="small"
                                    type="primary"
                                    @click="handleAssignRole(record)"
                                >
                                    <span>分配角色</span>
                                </a-button>
                                <a-button size="small" type="ghost">
                                    <edit-outlined />
                                    <span>编辑</span>
                                </a-button>
                            </a-space>
                        </template>
                    </template>
                </a-table>
            </div>
        </template>
        <template #page>
            <a-pagination
                v-model:current="queryParams.page"
                class="text-align-right"
                :default-page-size="queryParams.size"
                show-size-changer
                show-quick-jumper
                :total="dataCount"
                :show-total="(total:number) => `共${total}个用户`"
                @change="onChange"
            />
        </template>
        <UserRoleModal ref="userRoleModalRef" />
    </ListContainer>
</template>
