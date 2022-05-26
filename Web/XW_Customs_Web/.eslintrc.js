module.exports = {
    root: true,
    env: {
        node: true,
        "vue/setup-compiler-macros": true
    },
    globals: {
        __webpack_public_path__: true,
        app: true
    },
    extends: [
        "plugin:vue/vue3-essential",
        "eslint:recommended",
        "@vue/typescript/recommended",
        "plugin:prettier/recommended",
        "prettier"
    ],

    parserOptions: {
        ecmaVersion: 2020
    },
    rules: {
        "no-unused-vars": "off",
        "@typescript-eslint/no-explicit-any": ["off"],
        "vue/multi-word-component-names": [
            "off",
            {
                ignores: []
            }
        ],
        "prettier/prettier": [
            "off",
            {
                useTabs: true
            }
        ],
        "no-console": process.env.NODE_ENV === "production" ? "warn" : "off",
        "no-debugger": process.env.NODE_ENV === "production" ? "warn" : "off"
    }
};
