<template>
  <div :class="['ly-form-input', `ly-form-input-${type}`, { invalid, required }]">
    <label v-if="label" :for="name">
      {{ label }}
      <span v-if="!required" class="text-secondary">
        ({{ $t('ly.form.input.optional') }})
      </span>
    </label>

    <div class="ly-form-input-group">
      <input
        ref="input"
        :id="name"
        :name="name"
        :type="inputType"
        :value="inputValue"
        :placeholder="placeholder"
        :pattern="pattern"
        :required="required"
        :invalid="invalid"
        :autocomplete="autocomplete"
        @input="$emit('input', $event.target.value)"
      />

      <ly-button
        v-if="type == 'password'"
        type="ghost"
        icon="eye"
        @on="showPassword = true"
        @off="showPassword = false"
      >
        <span class="no-mobile">{{ $t('ly.form.input.revealPassword') }}</span>
      </ly-button>
    </div>

    <p v-if="invalid" class="ly-form-input-error">{{ error }}</p>
    <p v-if="caption" class="ly-form-input-caption">{{ caption }}</p>
  </div>
</template>

<script>
  import moment from 'moment'

  export default {
    props: {
      value: { type: [String, Number], required: true },
      type: { type: String, required: true },
      name: { type: String, required: true },
      placeholder: { type: String },
      pattern: { type: String },
      label: { type: String },
      caption: { type: String },
      error: { type: String },
      autocomplete: { type: String },
      required: { type: Boolean },
    },

    data () {
      return {
        showPassword: false,
        inputValue: this.type === 'date' ? moment.unix(this.value).format('YYYY-MM-DD') : this.value,
      }
    },

    computed: {
      invalid () {
        return !!this.error
      },

      inputType () {
        if (this.type === 'password') {
          return this.showPassword ? 'text' : 'password'
        }
        return this.type
      }
    },

    methods: {
      focus () {
        const { input } = this.$refs
        input && input.focus()
      },
    },
  }
</script>

<style lang="scss">
  .ly-form-input {
    label {
      display: block;
      margin-bottom: .25rem;
      padding-left: .5rem;
    }

    input {
      width: 100%;
      height: 2.5rem;
      padding: .5rem;

      font-size: 1rem;
      line-height: 1.5rem;
      font-family: inherit;

      border: 1px solid $ly-color-grey-40;
      box-shadow: 1px 1px 2px $ly-color-grey-20 inset;
      border-radius: .25rem;

      transition: border .2s ease-in-out;

      &[type="date"] {
        max-width: 10rem;
      }

      &:focus {
        border: 1px solid $ly-color-pine-50;
      }

      &::placeholder {
        color: $ly-color-grey-50;
      }
    }
    &.invalid input {
      border: 1px solid $ly-color-red-50;
    }
  }

  .ly-form-input-group {
    display: flex;

    > .ly-button {
      margin-left: .25rem;
      margin-right: 0;

      flex-shrink: 0;
    }
  }

  .ly-form-input-caption {
    margin-bottom: 0;
    padding-left: .5rem;

    color: $ly-color-grey-50;
    font-size: .8rem;
  }

  .ly-form-input-error {
    margin-bottom: 0;
    padding-left: .5rem;

    color: $ly-color-red-50;
    font-size: .8rem;
  }
</style>
