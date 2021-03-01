<template>
  <div class="row">
    <div class="col">
      <div class="card">
        <div class="card-body">
          <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
            <option selected>Select Company</option>
            <option v-for="company in companies" v-bind:value="company.id">{{company.name}}</option>
          </select>

          <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example">
            <option selected>Select Week</option>
            <option v-for="week in weeks" v-bind:value="week.value">{{week.name}}</option>
          </select>
        </div>
      </div>
    </div>
    <br>
  </div>

</template>

<script>
  export default {
    data: function() {
      return {
        companies: [
          { id: 1, name: "Company 1" },
          { id: 2, name: "Company 2" },
          { id: 3, name: "Company 3" }
        ],
        weeks: [
          { value: 10, name: "Week 10 of 2021" },
          { value: 11, name: "Week 11 of 2021" },
          { value: 12, name: "Week 12 of 2021" }
        ]
      } 
    }
  }
</script>