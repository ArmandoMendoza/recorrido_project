<template>

  <div>
    <div v-if="showModal">
      <transition name="modal">
        <div class="modal-mask">
          <div class="modal-wrapper">

              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title">Create Company</h5>
                    <button type="button" class="btn-close" @click="showModal=false" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <company-form></company-form>
                  </div>
                </div>
              </div>

          </div>
        </div>
      </transition>
    </div>

  <button id="show-modal" @click="showModal=true" class="btn btn-sm btn-primary m-1">Create Company</button>
 </div>

</template>

<script>
  import CompanyForm from './_form.vue'

  export default {

    data: function(){
      return {
        showModal: false
      }
    },

    components: {
      "company-form": CompanyForm
    },

    methods: {
      onHide: function(){
        console.log("here")
        this.showModal = false
      }
    }
  }
</script>

<style scoped>

  .modal-mask {
    position: fixed;
    z-index: 9998;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, .5);
    display: table;
    transition: opacity .3s ease;
  }

  .modal-wrapper {
    display: table-cell;
  }

</style>