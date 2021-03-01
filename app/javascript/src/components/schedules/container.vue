<template>

  <div class="row row-cols-1 row-cols-md-5 g-4">
    <schedule-table
      v-for="schedule in schedules"
      v-bind:key="schedule.date"
      v-bind:schedule="schedule"
    ></schedule-table>    
  </div>

</template>

<script>
  import Table from './_table.vue'

  export default {
    props: ["schedules"],
    components: {
      "schedule-table": Table
    }
  }
</script>
