<template>
  <div class="row row-cols-1 row-cols-md-5 g-1">
    <schedule-table
      v-for="schedule in schedules"
      v-bind:key="schedule.date"
      v-bind:schedule="schedule"
      v-bind:user="user"
    ></schedule-table>
  
  </div>

</template>

<script>
  import Table from './_table.vue'
  import axios from 'axios'

  export default {
    props: ["user", "schedules"],

    components: {
      "schedule-table": Table
    },

  }
</script>
