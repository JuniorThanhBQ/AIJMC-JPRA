import streamlit as st

st.set_page_config(page_title="AIJMC - JPRA", layout="wide")

st.title("Job Postings Reliability Analysis (JPRA)")
st.caption("AI-powered verification for Vietnamese job market postings")

job_url = st.text_input("Enter Job Posting URL:")
if st.button("Analyze Reliability"):
    if job_url:
        st.info(f"Target URL: {job_url}")
    else:
        st.warning("Please provide a valid URL.")
