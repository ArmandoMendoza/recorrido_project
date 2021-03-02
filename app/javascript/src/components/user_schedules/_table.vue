<template>

  <div class="col-4">
    <div class="card">
      <div class="card-body">
        <table class="table table-bordered">
          <thead>
            <tr>
              <td colspan="3" class="text-center td-title">{{schedule.date}}</td>
            </tr>
          </thead>
          <tbody>
            <table-tr
              v-for="value in schedule.values"
              v-bind:key="value.id"
              v-bind:value="value"
              v-bind:user="user"
            ></table-tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>

</template>

<script>
  import Tr from './_tr.vue'
  export default {
    props: ["schedule", "user"],
    components: {
      "table-tr": Tr
    }
  }
</script>

<style scoped>
  @import "../../assets/css/main.css"
</style>