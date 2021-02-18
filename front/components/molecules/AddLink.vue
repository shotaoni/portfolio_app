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
    type="text"
    v-model="firstUrlForVeeValidate"
    @input="$emit('update:firstUrl', $event.target.value)"
    placeholder="URL"
    />
    <div class="error-message">{{ errors[0] }}</div>
    </div>
    </ValidationProvider>

    <ValidationProvider
    v-slot="{ errors }"
    :rules="rules"
    :name="$attrs.label"
    >
    <div class="url-input">
    <input
    type="text"
    v-model="secondUrlForVeeValidate"
    @input="$emit('update:secondUrl', $event.target.value)"
    placeholder="URL"
    />
    <div class="error-message">{{ errors[0] }}</div>
    </div>
    </ValidationProvider>

    <ValidationProvider
    v-slot="{ errors }"
    :rules="rules"
    :name="$attrs.label"
    >
    <div class="url-input">
    <input
    type="text"
    v-model="thirdUrlForVeeValidate"
    @input="$emit('update:thirdUrl', $event.target.value)"
    placeholder="URL"
    />
    <div class="error-message">{{ errors[0] }}</div>
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
      default: ''
    },
    secondUrl: {
      type: String,
      default: ''
    },
    thirdUrl: {
      type: String,
      default: ''
    }
  },
  data () {
    return {
      firstUrlForVeeValidate: '',
      secondUrlForVeeValidate: '',
      thirdUrlForVeeValidate: ''
    }
  }
}
</script>

<style>
</style>
