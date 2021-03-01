<template>
  <div>
    <div class="row">
      <div class="col">
        <div class="card">
          <div class="card-body">
            <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" @change="onChangeCompany($event)">
              <option selected>Select Company</option>
              <option v-for="company in companies" v-bind:value="company.id">{{company.attributes.name}}</option>
            </select>

            <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" @change="onChangeWeek($event)">
              <option selected>Select Week</option>
              <option v-for="week in weeks" v-bind:value="week.value">{{week.name}}</option>
            </select>
          </div>
        </div>
      </div>
      <br>
    </div>
    <div class="row">
      <schedules_container
        :schedules=schedules
      ></schedules_container>
    </div>
  </div>

</template>

<script>
  import axios from 'axios'
  import SchedulesContainer from '../schedules/container.vue'


  export default {
    data: function() {
      return {
        companies: [],
        weeks: [],
        schedules: [
          { date: "Feb 10", values: [{ hour: "19:00 - 20:00", name: "Benjamin"}, { hour: "19:00 - 20:00", name: "" }] },
          { date: "Feb 11", values: [{ hour: "19:00 - 20:00", name: "Ernesto"}, { hour: "19:00 - 20:00", name: "Ernesto" }] },
          { date: "Feb 12", values: [{ hour: "19:00 - 20:00", name: "Barbara"}, { hour: "19:00 - 20:00", name: "Barbara "}] },
          { date: "Feb 13", values: [{ hour: "19:00 - 20:00", name: "Barbara"}, { hour: "19:00 - 20:00", name: "Barbara "}] },
          { date: "Feb 14", values: [{ hour: "19:00 - 20:00", name: "Barbara"}, { hour: "19:00 - 20:00", name: "Barbara "}] },
          { date: "Feb 15", values: [{ hour: "19:00 - 20:00", name: "Barbara"}, { hour: "19:00 - 20:00", name: "Barbara "}] },
          { date: "Feb 16", values: [{ hour: "19:00 - 20:00", name: "Barbara"}, { hour: "19:00 - 20:00", name: "Barbara "}] },        
        ]
      } 
    },

    methods: {
      onChangeCompany: function(event){
        let value = event.target.value
        if(value !== "Select Company"){
          axios
          .get(`/api/collections/companies/${value}/weeks`)
          .then((response)=>
            this.weeks = response.data.data
          )
        }else{
          this.weeks = []
        }
      },

      onChangeWeek: function(event){
        let value = event.target.value
        if(value !== "Select Week"){
          axios
          .get(`/api/collections/companies/${value}/weeks`)
          .then((response)=>
            this.weeks = response.data.data
          )
        }else{
          this.weeks = []
        }
      }
    },

    created: function() {
      axios
      .get("/api/collections/companies")
      .then((response)=>
        this.companies = response.data.data
      )
    },

    components: {
      schedules_container: SchedulesContainer
    }

  }
</script>