import globals from "globals";
import js from "@eslint/js";
import prettier from "eslint-config-prettier";

export default [
    {
        ignores: ["log/", "tmp/", "vendor/", "public/assets", "app/assets/builds", "coverage", "**/leaflet.js"],
    },
    js.configs.recommended,
    prettier,
    {
        languageOptions: {
            globals: {
                ...globals.browser,
                ...globals.node,
                L: true,
            },
        },
    },
];
