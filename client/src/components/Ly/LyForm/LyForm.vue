<template>
  <form class="ly-form" @submit.prevent="$emit('submit')">
    <slot></slot>
  </form>
</template>
