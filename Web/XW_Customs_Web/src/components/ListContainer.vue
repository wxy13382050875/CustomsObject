<script setup lang="ts">
    import { nextTick, onActivated, ref, useSlots } from "vue";
    import { useStore } from "@/store";

    const slots = useSlots();
    const tableHeight = ref<number>(0);
    const contentRef = ref();
    const formRef = ref();
    const toolsRef = ref();
    const store = useStore();
    const emits = defineEmits(["refresh"]);
    const props = defineProps({
        backgroundColor: {
            type: String,
            default: "#fff"
        }
    });

    const formStyle = ref({
        padding: slots.form ? "24px" : "0",
        marginBottom: slots.form ? "16px" : "0",
        backgroundColor: props.backgroundColor
    });

    const listStyle = ref({
        padding: slots.table ? "24px 24px 0 24px" : "0",
        backgroundColor: props.backgroundColor
    });

    const tableStyle = ref({
        backgroundColor: props.backgroundColor
    });

    const toolsStyle = ref({
        marginBottom: slots.tools ? "16px" : "0"
    });
    onActivated(() => {
        if (store.state.tabs.refresh) {
            store.state.tabs.refresh = false;
            emits("refresh");
        }
    });
    nextTick(() => {
        calculateHeight();
    });

    window.onresize = () => {
        calculateHeight();
    };

    const calculateHeight = () => {
        tableHeight.value =
            contentRef.value.offsetHeight -
            formRef.value.offsetHeight -
            toolsRef.value.offsetHeight -
            (slots.tools ? 140 : 180);
    };
</script>
<template>
    <div class="list-container">
        <div ref="contentRef" class="content">
            <div ref="formRef" :style="formStyle" class="form">
                <slot name="form"> </slot>
            </div>
            <div class="list" :style="listStyle">
                <div ref="toolsRef" :style="toolsStyle" class="tools">
                    <slot name="tools"></slot>
                </div>
                <div class="table" :style="tableStyle">
                    <slot name="table" :height="tableHeight"> </slot>
                </div>
                <div class="page">
                    <slot name="page"> </slot>
                </div>
            </div>
            <slot></slot>
        </div>
    </div>
</template>
<style lang="scss" scoped>
    .list-container {
        padding: 10px;
        height: 100%;
        .content {
            display: flex;
            flex-direction: column;
            padding: 10px;
            height: 100%;
            // background-color: #fff;
            border-radius: 4px;
            .form,
            .list {
            }
            .list {
                flex: 1;
                .page {
                    text-align: center;
                }
            }
        }
    }
</style>
