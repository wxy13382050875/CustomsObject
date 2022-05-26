export type SysState = {
    isQianKun: boolean;
};

export const state: SysState = {
    isQianKun: (window as any).__POWERED_BY_QIANKUN__ || false
};

export const mutations = {};
export const actions = {};
export const getters = {
    getIsQianKun(state: SysState): boolean {
        return state.isQianKun;
    }
};

export default {
    namespaced: true,
    state,
    mutations,
    actions,
    getters
};
