<template>
  <div class="add-link-box">
    <v-card-title>
      <h3>リンクを追加する</h3>
    </v-card-title>
    <ValidationProvider
      v-slot="{ errors }"
      :rules="rules"
      :name="$attrs.label"
    >
      <div class="url-input">
        <input
          v-model="firstUrlForVeeValidate"
          type="text"
          placeholder="URL"
          @input="$emit('update:firstUrl', $event.target.value)"
        >
        <div class="error-message">
          {{ errors[0] }}
        </div>
      </div>
    </ValidationProvider>
  </div>
</template>

<script>
export default {
  props: {
    rules: {
      type: [Object, String],
      default: ''
    },
    firstUrl: {
      type: String,
      required: false,
      default: ''
    }
  },
  data () {
    return {
    }
  },
  computed: {
    firstUrlForVeeValidate: {
      get () {
        return this.firstUrl
      },
      set (firstUrl) {
        this.$emit('input', firstUrl)
      }
    }
  }
}
</script>

<style>
</style>
