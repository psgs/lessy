<template>
  <div :class="['ly-form-input', 'ly-form-input-textarea', { invalid, required }]">
    <label v-if="label" :for="name">
      {{ label }}
      <span v-if="!required" class="text-secondary">
        ({{ $t('ly.form.input.optional') }})
      </span>
    </label>

    <textarea
      ref="textarea"
      :id="name"
      :name="name"
      :value="value"
      :required="required"
      :invalid="invalid"
      @input="$emit('input', $event.target.value)"
    ></textarea>

    <p v-if="invalid" class="ly-form-input-error">{{ error }}</p>
    <p v-if="caption" class="ly-form-input-caption">{{ caption }}</p>
  </div>
</template>

<script>
  import autosize from 'autosize'

  export default {
    props: {
      value: { type: String, required: true },
      name: { type: String, required: true },
      label: { type: String },
      caption: { type: String },
      error: { type: String },
      required: { type: Boolean },
    },

    computed: {
      invalid () {
        return !!this.error
      },
    },

    mounted () {
      autosize(this.$refs.textarea)
    },

    beforeDestroy () {
      autosize.destroy(this.$refs.textarea)
    },
  }
</script>

<style lang="scss">
  .ly-form-input {
    textarea {
      width: 100%;
      min-height: 7rem;
      padding: .5rem;

      font-size: 1rem;
      line-height: 1.5rem;
      font-family: inherit;

      border: 1px solid $ly-color-grey-40;
      box-shadow: 1px 1px 2px $ly-color-grey-20 inset;
      border-radius: .25rem;

      transition: border .2s ease-in-out;

      &:focus {
        border: 1px solid $ly-color-pine-50;
      }
    }
    &.invalid textarea {
      border: 1px solid $ly-color-red-50;
    }
  }
</style>
