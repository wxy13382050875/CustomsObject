<script setup lang="ts">
    import { ref } from "vue";
    import { appList } from "@/api/app";
    import type { IApp } from "@/api/app";

    const props = defineProps({
        placeholder: {
            type: String,
            default: ""
        },
        modelValue: {
            type: String,
            require: true
        }
    });
    defineEmits(["update:modelValue"]);
    const dataList = ref<IApp[]>();
    appList().then((data) => {
        dataList.value = data.content;
    });
</script>
<template>
    <a-select
        show-search
        allow-clear
        :modelValue="modelValue"
        :placeholder="placeholder"
        @update:modelValue="(val:string) => $emit('update:modelValue', val)"
    >
        <a-select-option v-for="item in dataList" :value="item.id" :key="item.id">
            {{ item.name }}
        </a-select-option>
    </a-select>
</template>
