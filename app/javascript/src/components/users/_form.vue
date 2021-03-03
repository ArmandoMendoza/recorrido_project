<template>
  
  <form>
    <p class="text-danger" v-if="hasErrors">
       {{ formatedErrorMsg }}
    </p>
    <div class="mb-2 row">
      <div class="col">
        <label for="exampleFormControlInput1" class="form-label" v-bind:class="{ 'text-danger': hasErrors }">Company *</label>
        <select class="form-select form-select-lg mb-3" aria-label=".form-select-lg example" v-model="company_id">
          <option v-for="company in companies" v-bind:value="company.id">{{company.attributes.name}}</option>
        </select>
      </div>
    </div>
    <div class="mb-3 row">
      <div class="col-md-10">
        <label for="exampleFormControlInput1" class="form-label" v-bind:class="{ 'text-danger': hasErrors }">Name *</label>
        <input type="text" class="form-control" v-model="name" required>
      </div>
      <div class="col">
        <label for="exampleFormControlInput1" class="form-label" v-bind:class="{ 'text-danger': hasErrors }">Color *</label>
        <input type="color" class="form-control form-control-color" v-model="color" value="#563d7c" title="Choose user color">
      </div>
    </div>
    <div class="mb-3 row">
      <div class="col">
      <button type="button" class="btn btn-primary" @click="sendData" v-bind:disabled="loading">
        <span class="spinner-border spinner-border-sm" v-if="loading" role="status" aria-hidden="true"></span>
        Save
      </button>
      <!-- <button type="button" class="btn btn-secondary" @click="hideModal">Close</button> -->
      </div>
    </div>
  </form>

</template>

<script>
  import _ from 'lodash'
  import axios from 'axios'

  export default {

    data: function(){
      return {
        companies: [],
        hasErrors: false,
        errorsMsg: [],
        company_id: null,
        name: null,
        color: null,
        loading: false
      }
    },

    computed: {
      formatedErrorMsg: function(){
        return this.errorsMsg.join(", ")
      }
    },

    methods: {

      success: function(response){
        this.loading = false
        console.log("ok",response)
        window.location.reload()
      },

      handleErrors: function(data){
        this.loading = false
        this.hasErrors = true
        this.errorsMsg = data
      },

      sendData: function(){
        if (this.company_id === null){
          this.hasErrors = true
          this.errorsMsg = ["Must select a Company"]
          return
        }

        let self = this
        let formData = {
          user: { 
            name: this.name,
            color: this.color
          },
        }

        let csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content")
        let config = {
          headers: { "X-CSRF-Token": csrfToken }
        }
        this.loading = true
        axios.post(`/api/companies/${this.company_id}/users`, formData, config)
        .then(function(response){
          self.success(response)
        })
        .catch(function(error){
          self.handleErrors(error.response.data)
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
  
  }

</script>
