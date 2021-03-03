<template>

  <div class="col-4">
    <div class="card">
      <div class="card-body">
        <table class="table table-bordered">
          <thead>
            <tr>
              <td class="text-center td-title">{{schedule.date}}</td>
              <td class="text-center td-title">
                <input
                  type="checkbox"
                  v-model="checkall"
                >
              </td>
            </tr>
          </thead>
          <tbody>
            <table-tr
              v-for="value in this.schedule.values"
              v-bind:key="value.id"
              v-bind:value="value"
              v-bind:user="user"
              v-bind:checked="checkall"
            ></table-tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>

</template>

<script>
  import Tr from './_tr.vue'
  import _ from 'lodash'

  export default {
    props: ["schedule", "user"],
    
    data: function(){
      return {
        checkall: _.every(this.schedule.values, { available: true }),
        checked: false,
      }
    },

    components: {
      "table-tr": Tr
    },

    watch: {
      schedule: function(newVal, oldVal){
        this.checkall = _.every(this.schedule.values, { available: true })
      }
    }

  }
</script>

<style scoped>
  @import "../../assets/css/main.css"
</style>