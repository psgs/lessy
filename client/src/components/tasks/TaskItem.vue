<template>
  <edit-task
    v-if="editMode"
    :task="task"
    :onSuccess="stopEditMode"
    :onCancel="stopEditMode"
  ></edit-task>
  <list-item v-else :class="['task-item', { finished: task.isFinished }]">
    <container row align="center">
      <span class="my-handle">::</span>

      <a v-if="!notoggle" href="#" @click.prevent="toggleFinishTask" class="toggle">
        <icon v-if="task.isFinished" name="check-square-o"></icon>
        <icon v-else name="square-o"></icon>
      </a>
      <div class="label adapt">
        {{ task.label }}
        <badge
          v-if="task.restartedCount > 0"
          v-tooltip.top="$tc('tasks.restarted', task.restartedCount, { count: task.restartedCount })"
        >
          <icon name="repeat"></icon> {{ task.restartedCount }}
        </badge>
      </div>

      <popover>
        <icon slot="toggle" name="ellipsis-h"></icon>

        <template slot="menu">
          <popover-item :action="startEditMode">{{ $t('tasks.edit') }}</popover-item>
          <popover-item :action="confirmAbandon">{{ $t('tasks.abandon') }}</popover-item>
        </template>
      </popover>
    </container>
  </list-item>
</template>

<script>
  import EditTask from '../forms/EditTask'

  export default {

    props: {
      'task': { type: Object, required: true },
      'notoggle': { type: Boolean },
    },

    components: {
      EditTask,
    },

    data () {
      return {
        editMode: false,
      }
    },

    methods: {
      toggleFinishTask () {
        const { task } = this
        if (task.isFinished) {
          this.$store.dispatch('tasks/restart', { task })
        } else {
          this.$store.dispatch('tasks/finish', { task })
        }
      },

      startEditMode () {
        this.editMode = true
      },

      stopEditMode () {
        this.editMode = false
      },

      confirmAbandon () {
        const { task } = this
        if (window.confirm(this.$t('tasks.confirmAbandon'))) {
          this.$store.dispatch('tasks/abandon', { task })
        }
      },
    },

  }
</script>

<style lang="scss">

  .task-item {
    .my-handle {
      padding: 5px;
      visibility: hidden;
      cursor: move;
    }
    &:hover .my-handle {
      visibility: visible;
    }

    .toggle {
      padding: 5px;
    }

    &:nth-child(even) {
      background-color: #f4f4f4;
    }

    &.finished .label {
      color: #999;
      text-decoration: line-through;
    }
    &.finished .toggle {
      color: #999;
    }

    .popover-toggle {
      padding: 2px;

      background-color: $color-primary-shadow;
      border: 1px solid darken($color-primary-shadow, 10%);
      border-radius: 50%;

      &:hover {
        background-color: darken($color-primary-shadow, 10%);
      }
    }
    .popover { visibility: hidden; }
    &:hover .popover { visibility: visible; }
  }

</style>