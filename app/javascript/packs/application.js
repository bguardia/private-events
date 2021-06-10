// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

function toggleClass(el, classStr) {
    
    if ( el.className.indexOf(classStr) >= 0 ) {
        const patt = new RegExp("\\s?" + classStr)
        el.className = el.className.replace(patt, "")
    } else {
        el.className = el.className.concat(" ", classStr)
    }
};

function toggleVisibleTab() {
    let active_tab = document.getElementsByClassName("is-active")[0];
    let this_tab = this

    if (active_tab != this_tab) {
        let active_container = document.getElementById(active_tab.id.replace("tab", "container"))
        let this_container = document.getElementById(this_tab.id.replace("tab", "container"))

        toggleClass(this_tab, "is-active")
        toggleClass(active_tab, "is-active")
        toggleClass(this_container, "is-hidden")
        toggleClass(active_container, "is-hidden")
    }

}

function showSentInvitations() {
    let sent_tab = document.getElementById("sent_invitations_tab");
    let received_tab = document.getElementById("received_invitations_tab");

    let sent_el = document.getElementById("sent_invitations_container");
    let received_el = document.getElementById("received_invitations_container");
    if ( sent_el.className.indexOf("is-hidden") > 0 ) {
        toggleClass(sent_el, "is-hidden");
        toggleClass(received_el, "is-hidden");
        toggleClass(sent_tab, "is-active");
        toggleClass(received_tab, "is-active");
    }
};

function showReceivedInvitations() {
    let sent_tab = document.getElementById("sent_invitations_tab");
    let received_tab = document.getElementById("received_invitations_tab");

    let sent_el = document.getElementById("sent_invitations_container");
    let received_el = document.getElementById("received_invitations_container");
    if ( received_el.className.indexOf("is-hidden") > 0 ) {
        toggleClass(sent_el, "is-hidden");
        toggleClass(received_el, "is-hidden");
        toggleClass(sent_tab, "is-active");
        toggleClass(received_tab, "is-active");
    }
};

function setTabEvents(){
    /*
    let sent_tab = document.getElementById("sent_invitations_tab");
    let received_tab = document.getElementById("received_invitations_tab");
    if ( sent_tab && received_tab ) {
        sent_tab.addEventListener("click", showSentInvitations);
        received_tab.addEventListener("click", showReceivedInvitations)
    }*/

    let tabs = document.getElementsByClassName("tab")
    for(let i = 0; i < tabs.length; i++) {
        tabs[i].addEventListener("click", toggleVisibleTab)
    }
}

window.addEventListener("turbolinks:load", setTabEvents)
