export interface IListPagenation<T> {
    content: T[];
    pageNum: number;
    pageSize: number;
    count: number;
}
