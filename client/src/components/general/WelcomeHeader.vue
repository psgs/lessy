<template>
  <header class="welcome-header">
    <ly-text-container margined>
      <router-link class="welcome-header-brand" to="/">{{ $t('general.welcomeHeader.lessy') }}</router-link>
    </ly-text-container>
  </header>
</template>

<style lang="scss">
  .welcome-header {
    padding: 1rem 2rem;

    background: linear-gradient(45deg, $ly-color-grey-20,
                                       $ly-color-grey-20 calc(100% - 11rem),
                                       $ly-color-pine-60 calc(100% - 11rem),
                                       $ly-color-pine-60 calc(100% - 10.5rem),
                                       $ly-color-grey-20 calc(100% - 10.5rem),
                                       $ly-color-grey-20 calc(100% - 10rem),
                                       $ly-color-pine-60 calc(100% - 10rem));
  }

  .welcome-header-brand {
    color: $ly-color-grey-90;
    font-size: 1.2rem;
    font-weight: bold;
    text-decoration: none;
  }
</style>
