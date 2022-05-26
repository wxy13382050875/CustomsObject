const { defineConfig } = require("@vue/cli-service");
const { name } = require("./package");
module.exports = defineConfig({
    transpileDependencies: true,
    publicPath: "/",
    devServer: {
        allowedHosts: "all"
    },
    css: {
        loaderOptions: {
            sass: {
                // additionalData: `@import "@/assets/style/function.scss";`
            }
        }
    }
});
