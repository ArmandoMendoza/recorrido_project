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
    data: function() {
      return {
        schedules: [
          { date: "Feb 10", values: [{ hour: "19:00 - 20:00", name: "Benjamin"}, { hour: "19:00 - 20:00", name: "" }] },
          { date: "Feb 11", values: [{ hour: "19:00 - 20:00", name: "Ernesto"}, { hour: "19:00 - 20:00", name: "Ernesto" }] },
          { date: "Feb 12", values: [{ hour: "19:00 - 20:00", name: "Barbara"}, { hour: "19:00 - 20:00", name: "Barbara "}] },
          { date: "Feb 13", values: [{ hour: "19:00 - 20:00", name: "Barbara"}, { hour: "19:00 - 20:00", name: "Barbara "}] },
          { date: "Feb 14", values: [{ hour: "19:00 - 20:00", name: "Barbara"}, { hour: "19:00 - 20:00", name: "Barbara "}] },
          { date: "Feb 15", values: [{ hour: "19:00 - 20:00", name: "Barbara"}, { hour: "19:00 - 20:00", name: "Barbara "}] },
          { date: "Feb 16", values: [{ hour: "19:00 - 20:00", name: "Barbara"}, { hour: "19:00 - 20:00", name: "Barbara "}] },
        ],
      } 
    },
    components: {
      "schedule-table": Table
    }
  }
</script>
