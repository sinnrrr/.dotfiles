import "npm:typescript@5.9.3";
import { defineConfig } from "npm:eslint@10.15.0/config";
import tseslint from "npm:typescript-eslint@8.73.0";

export default defineConfig({
  files: ["**/*.{ts,tsx,mts,cts}"],
  extends: [tseslint.configs.base],
  languageOptions: { parserOptions: { projectService: true, tsconfigRootDir: process.cwd() } },
  linterOptions: { noInlineConfig: true, reportUnusedDisableDirectives: "off" },
  rules: {
    "@typescript-eslint/no-floating-promises": "error",
    "@typescript-eslint/no-misused-promises": "error",
    "@typescript-eslint/await-thenable": "error",
    "@typescript-eslint/no-unsafe-assignment": "error",
    "@typescript-eslint/no-unsafe-call": "error",
    "@typescript-eslint/no-unsafe-member-access": "error",
    "@typescript-eslint/no-unsafe-return": "error",
    "@typescript-eslint/no-unsafe-argument": "error",
    "@typescript-eslint/no-explicit-any": "error",
  },
});
