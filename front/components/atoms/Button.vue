<template>
  <v-btn
    icon
    v-bind="$attrs"
    v-on="$listeners"
    @click="$emit('tap')"
  >
    <v-icon v-bind="$attrs">
      <slot />
      {{ type }}
    </v-icon>
  </v-btn>
</template>

<script>
export default {
  props: {
    type: {
      type: String,
      required: true
    }
  }
}
</script>

<style>
</style>
