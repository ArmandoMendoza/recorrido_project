<template>

  <div class="row row-cols-1 row-cols-md-5 g-4">
    <schedule-table
      v-for="schedule in schedules"
      v-bind:key="schedule.date"
      v-bind:schedule="schedule"
    ></schedule-table>

    <div class="col-4" v-if="total.length > 0 ">
      <div class="card">
        <div class="card-body">
          <table class="table table-bordered">
            <tr v-for="value in total">
              <td>{{value.name}}</td>
              <td>{{value.total}}</td>
            </tr>
          </table>
          </ul>
        </div>
      </div>
    </div>
  
  </div>

</template>

<script>
  import Table from './_table.vue'

  export default {
    props: ["schedules", "total"],

    computed: {
      checkTotal: function(){
        console.log(this.total)
        return this.total.length > 0 
      }
    },

    components: {
      "schedule-table": Table
    }
  }
</script>
