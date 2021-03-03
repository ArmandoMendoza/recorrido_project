<template>
  <div>
    <div class="row">
      <div class="col">
        <div class="card">
          <div class="card-body">
            <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" @change="onChangeCompany" v-model="company_id">
              <option value="null" disabled selected>Select a Company</option>
              <option v-for="company in companies" v-bind:value="company.id">{{company.attributes.name}}</option>
            </select>

            <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" @change="onChangeWeek" v-model="week">
              <option v-for="week in weeks" v-bind:value="week.value">{{week.name}}</option>
            </select>
            <div class="row" v-if="schedules.length > 0">
              <div class="col">
                <h3>{{ dateText }}</h3>
              </div>

              <div class="col text-end">
                <a class="btn btn-primary" v-bind:href="editUrl" data-turbolinks="false" role="button">Edit Availability</a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <br>
    </div>
    <div class="row">
      <schedules-container
        :schedules=schedules
        :total=total
      ></schedules-container>
    </div>
  </div>

</template>

<script>
  import axios from 'axios'
  import CompanySchedulesContainer from '../company_schedules/container.vue'


  export default {
    data: function() {
      return {
        company_id: null,
        week: null,
        editUrl: "#",
        companies: [],
        weeks: [],
        schedules: [],
        total: []
      } 
    },

    computed: {
      dateText: function(){
        if (this.schedules.length > 0){
          return `Week from [${this.schedules[0]["date"]}] to [${this.schedules[this.schedules.length-1]["date"]}] `
        }
      }
    },

    methods: {
      onChangeCompany: function(event){
        axios
        .get(`/api/collections/companies/${this.company_id}/weeks`)
        .then((response)=>{
          this.weeks = response.data.data
          this.week = this.weeks[0]["value"]
          this.fetchSchedules()
        })
        .catch((error)=>{
          this.company_id = null
          this.weeks = []
          this.schedules = []
          this.total = []
        })
      },

      onChangeWeek: function(event){
        this.fetchSchedules()
      },

      fetchSchedules: function(){
        this.editUrl = `/companies/${this.company_id}/week/${this.week}`
        axios
        .get(`/api/companies/${this.company_id}/schedules`, { params: { week: this.week } })
        .then((response)=>{
          this.schedules = response.data.data.schedules
          this.total = response.data.data.total
        })
        .catch((error)=>{
          this.week = null
          this.schedules = []
          this.total = []
        })
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
      "schedules-container": CompanySchedulesContainer
    }

  }
</script>