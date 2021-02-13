import Vue from 'vue'
import { ValidationProvider, ValidationObserver, localize, extend } from 'vee-validate' // 使用する機能
import ja from 'vee-validate/dist/locale/ja.json' // エラーメッセージの日本語化用
import * as rules from 'vee-validate/dist/rules' // 使用するバリデーションルール
/*  eslint import/namespace: ["error", { allowComputed: true }]  */
for (const rule in rules) {
  extend(rule, rules[rule])
}

Vue.component('ValidationProvider', ValidationProvider)
Vue.component('ValidationObserver', ValidationObserver)
localize('ja', ja)
