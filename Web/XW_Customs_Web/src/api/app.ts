import http from "@/utils/http";
import { IListPagenation } from "@/interface/IResposeData";
export interface IApp {
    id?: number;
    name: string;
    code?: string;
    note: string;
}

/**
 * 应用列表
 * @returns
 */
export const appList = (): Promise<IListPagenation<IApp>> => {
    return http.get("/app", { params: { page: 1, size: 100 } });
};

export const appSave = (params: IApp) => {
    return http.post("/app", params);
};

export const appUpdate = (params: IApp) => {
    return http.put(`/app/${params.id}`, params);
};
