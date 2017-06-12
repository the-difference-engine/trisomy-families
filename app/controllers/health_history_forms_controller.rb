class HealthHistoryFormsController < ApplicationController
  def new
    if params[:child_id]
      @child = Child.find_by(id: params[:child_id])
      @congenital_heart_defect = CongenitalHeartDefect.new
      @intestinal_issue = IntestinalIssue.new
      @gastric_surgery = GastricSurgery.new
      @nuerological_condition = NuerologicalCondition.new
      @muscular_skeletal = MuscularSkeletal.new
      @cranial_facial = CranialFacial.new
      @endocrine = Endocrine.new
      @hearing = Hearing.new
      @vision = Vision.new
      @behavioral_health = BehavioralHealth.new
      @received_therapy = ReceivedTherapy.new
      @health_history = HealthHistory.new
      render 'new.html.erb'
    else
      flash[:danger] = 'Something went wrong: no child_id in params found!'
      redirect_to '/'
    end   
  end

  def create
    @child = Child.find_by(id: params[:child_id])
    @congenital_heart_defect = CongenitalHeartDefect.new(
      asd: params[:asd],
      vsd: params[:vsd],
      pda: params[:pda],
      av_canal_defect: params[:av_canal_defect],
      dorv: params[:dorv],
      tof: params[:tof],
      pfo: params[:pfo],
      not_applicable: params[:not_applicable],
      other: params[:other]
    )
    @congenital_heart_defect.save
    @intestinal_issue = IntestinalIssue.new(
      duodenal_atresia_stenosis_web: params[:duodenal_atresia_stenosis_web],
      anal_stenosis_atresia: params[:anal_stenosis_atresia],
      esophageal_atresia: params[:esophageal_atresia],
      hirschsprung_disease: params[:hirschsprung_disease],
      chronic_constipation: params[:chronic_constipation],
      dysphagia: params[:dysphagia],
      aspiration: params[:aspiration],
      chronic_diarrhea: params[:chronic_diarrhea],
      pyloric_stenosis: params[:pyloric_stenosis],
      gastroesophageal_reflux: params[:gastroesophageal_reflux],
      pepticulcers_gallstones: params[:pepticulcers_gallstones],
      hemorrhoids: params[:hemorrhoids],
      diverticulitis_diverticulosis: params[:diverticulitis_diverticulosis],
      colorectal_carcinoma: params[:colorectal_carcinoma],
      ibs: params[:ibs],
      ibd: params[:ibd]
    )
    @intestinal_issue.save
    @gastric_surgery = GastricSurgery.new(
      repair_of_duodenal_atresia_stenosis_web: params[:repair_of_duodenal_atresia_stenosis_web],
      repair_of_anal_stenosis_atresia: params[:repair_of_anal_stenosis_atresia],
      gastrostomy_tube_placement: params[:gastrostomy_tube_placement],
      surgery_for_hirschsprung_disease: params[:surgery_for_hirschsprung_disease],
      fundoplication_nissen_wrap: params[:fundoplication_nissen_wrap],
      none: params[:none],
      other: params[:other_gastric_surgery]
    )
    @gastric_surgery.save
    @nuerological_condition = NuerologicalCondition.new(
      seizure_epilsepsy: params[:seizure_epilepsy],
      brain_malformation: params[:brain_malformation],
      cyst: params[:cyst],
      cp: params[:cp],
      stroke: params[:stroke],
      unsure: params[:unsure],
      brain_malformation_surgery: params[:brain_malformation_surgery],
      cyst_surgery: params[:cyst_surgery],
      cp_surgery: params[:cp_surgery],
      stroke_surgery: params[:stroke_surgery],
      other: params[:other_nuero_surgery]
    )
    @nuerological_condition.save
    @muscular_skeletal = MuscularSkeletal.new(
      atlanto_axial_instability: params[:atlanto_axial_instability],
      cervical_spine_degeneration: params[:cervical_spine_degeneration],
      osteopenia: params[:osteopenia],
      osteoporosis: params[:osteoporosis],
      fractures: params[:fractures],
      scoliosis: params[:scoliosis],
      lordosis: params[:lordosis],
      kyphosis: params[:kyphosis],
      hand_bone_missing: params[:hand_bone_missing],
      leg_bone_missing: params[:leg_bone_missing],
      rib_deformities: params[:rib_deformities],
      club_foot: params[:club_foot],
      rocker_bottom_feet: params[:rocker_bottom_feet],
      atlanto_axial_instability_surgery: params[:atlanto_axial_instability_surgery],
      cervical_spine_degeneration_surgery: params[:cervical_spine_degeneration_surgery],
      osteopenia_surgery: params[:osteopenia_surgery],
      osteoporosis_surgery: params[:osteoporosis_surgery],
      fractures_surgery: params[:fractures_surgery],
      scoliosis_surgery: params[:scoliosis_surgery],
      lordosis_surgery: params[:lordosis_surgery],
      kyphosis_surgery: params[:kyphosis_surgery],
      hand_bone_missing_surgery: params[:hand_bone_missing_surgery],
      leg_bone_missing_surgery: params[:leg_bone_missing_surgery],
      rib_deformities_surgery: params[:rib_deformities_surgery],
      club_foot_surgery: params[:club_foot_surgery],
      rocker_bottom_feet_surgery: params[:rocker_bottom_feet_surgery]
    )
    @muscular_skeletal.save
    @cranial_facial = CranialFacial.new(
      cranial_deformities: params[:cranial_deformities],
      cleft_palate: params[:cleft_palate],
      cleft_lip: params[:cleft_lip],
      high_arch: params[:high_arch],
      low_set_ears: params[:low_set_ears],
      wide_spaced_eyes: params[:wide_spaced_eyes],
      wild_eyebrows: params[:wild_eyebrows],
      extraordinarily_long_eyelashes: params[:extraordinarily_long_eyelashes],
      overgrowth_of_gums: params[:overgrowth_of_gums],
      delayed_teething: params[:delayed_teething]
    )
    @cranial_facial.save
    @endocrine = Endocrine.new(
      hyperthyroidism: params[:hyperthyroidism],
      hypothyroidism: params[:hypothyroidism],
      early_onset_pubic_hair: params[:early_onset_pubic_hair],
      early_onset_puberty: params[:early_onset_puberty],
      growth_hormone_deficiency: params[:growth_hormone_deficiency],
      calcium_deficiency: params[:calcium_deficiency],
      high_cortisol: params[:high_cortisol],
      diabetes: params[:diabetes],
      hypoglycemia: params[:hypoglycemia],
      cushings_disease: params[:cushings_disease],
      vitamin_d_deficiency: params[:vitamin_d_deficiency],
      anemia: params[:anemia],
      failure_to_thrive: params[:failure_to_thrive],
      high_blood_pressure: params[:high_blood_pressure],
      low_blood_pressure: params[:low_blood_pressure],
      delayed_late_puberty: params[:delayed_late_puberty],
      unsure: params[:unsure],
      other: params[:other_endocrine],
      high_blood_sugar: params[:high_blood_sugar],
      unhealthy_cholesterol_levels: params[:unhealthy_cholesterol_levels],
      increased_abdominal_fat: params[:increased_abdominal_fat]
    )
    @endocrine.save
    @hearing = Hearing.new(
      transient: params[:transient],
      conductive: params[:conductive],
      nerve_loss: params[:nerve_loss],
      unknown: params[:unknown],
      other: params[:other_hearing]
    )
    @hearing.save
    @vision = Vision.new(
      cataract: params[:cataract],
      strabismus: params[:strabismus],
      lazy_eye: params[:lazy_eye],
      near_sighted: params[:near_sighted],
      far_sighted: params[:far_sighted],
      cvi: params[:cvi],
      astigmatism: params[:astigmatism],
      ptosis: params[:ptosis],
      blockage_of_tear_duct: params[:blockage_of_tear_duct],
      depth_perception_problems: params[:depth_perception_problems],
      blindness: params[:blindness],
      glaucoma: params[:glaucoma],
      torn_retina: params[:torn_retina],
      detached_retina: params[:detached_retina],
      undeveloped_eyes: params[:undeveloped_eyes],
      underdeveloped_eyes: params[:underdeveloped_eyes],
      undeveloped_eye_socket: params[:undeveloped_eye_socket],
      underdeveloped_eye_socket: params[:underdeveloped_eye_socket],
      dry_eyes: params[:dry_eyes],
      doesnt_blink_well: params[:doesnt_blink_well],
      doesnt_close_eyes_when_sleeping: params[:doesnt_close_eyes_when_sleeping]
    )
    @vision.save
    @behavioral_health = BehavioralHealth.new(
      add: params[:add],
      adhd: params[:adhd],
      bipolar: params[:bipolar],
      autism_spectrum: params[:autism_spectrum],
      depression: params[:depression],
      anxiety_disorder: params[:anxiety_disorder],
      ocd: params[:ocd],
      schizophrenia: params[:schizophrenia],
      addictions: params[:addictions],
      personality_disorder: params[:personality_disorder],
      eating_disorder: params[:eating_disorder],
      odd: params[:odd],
      other_delay: params[:other_delay],
      other_diagnosis: params[:other_diagnosis],
      conduct_disorder: params[:conduct_disorder],
      none: params[:none],
      learning_disability: params[:learning_disability],
      global_developmental_delay: params[:global_developmental_delay],
      intellectual_disability: params[:intellectual_disability],
      speech_delay: params[:speech_delay],
      receptive_delay: params[:receptive_delay],
      expressive_delay: params[:expressive_delay],
      auditory_processing_disorder: params[:auditory_processing_disorder],
      apraxia_dyspraxia: params[:apraxia_dyspraxia],
      visual_processing: params[:visual_processing]
    )
    @behavioral_health.save
    @received_therapy = ReceivedTherapy.new(
      ot: params[:ot],
      pt: params[:pt],
      dt: params[:dt],
      st: params[:st],
      dtv: params[:dtv],
      dth: params[:dth],
      vital_stim: params[:vital_stim],
      aquatic: params[:aquatic],
      reflex_integration: params[:reflex_integration],
      hippotherapy_equine: params[:hippotherapy_equine],
      hyperbaric: params[:hyperbaric],
      other: params[:other_therapy]
    )
    @received_therapy.save
    
    @health_history = HealthHistory.new(
      chd: params[:chd],
      chd_id: @congenital_heart_defect.id,
      offered_cardiac_surgery: params[:offered_cardiac_surgery],
      first_cardiac_surgery_age: params[:first_cardiac_surgery_age],
      first_cardiac_surgery_successful: params[:first_cardiac_surgery_successful],
      multiple_cardiac_surgeries: params[:multiple_cardiac_surgeries],
      intestinal_issues_id: @intestinal_issue.id,
      gastric_surgery_id: @gastric_surgery.id,
      seizure_epilepsy: params[:seizure_epilepsy],
      nuerological_condition_id: @nuerological_condition.id,
      muscular_skeletal_id: @muscular_skeletal.id,
      sleep_apnea: params[:sleep_apnea],
      cranial_facial_id: @cranial_facial.id,
      cancer: params[:cancer],
      other_cancer: params[:cancer_other],
      endocrine_id: @endocrine.id,
      hearing_test: params[:hearing_test],
      had_an_abr: params[:had_an_abr],
      hearing_loss_or_deaf: params[:hearing_loss_or_deaf],
      hearing_loss_treatment: params[:hearing_loss_treatment],
      failed_eye_exam: params[:failed_eye_exam],
      hearing_id: @hearing.id,
      vision_id: @vision.id,
      behavioral_health_id: @behavioral_health.id,
      in_ei: params[:in_ei],
      attend_school: params[:attend_school],
      home_schooled_bound: params[:home_schooled_bound],
      highest_education: params[:highest_education],
      received_therapy_id: @received_therapy.id,
      clinical_trial: params[:clinical_trial],
      clinical_trial_participation: params[:clinical_trial_participation]
    )
    @health_history.save
    if @congenital_heart_defect.save &&
       @gastric_surgery.save &&
       @nuerological_condition.save &&
       @muscular_skeletal.save &&
       @cranial_facial.save &&
       @endocrine.save &&
       @hearing.save &&
       @vision.save &&
       @behavioral_health.save &&
       @received_therapy.save &&
       @health_history.save &&
       @child.update(
         health_history_id: @health_history.id
       )
      flash[:success] = "Health History Added!"
      redirect_to "/profile/#{@child.id}"
    else
      flash[:warning] = "Health History Could Not Be Added!"
      render 'new.html.erb'
    end
  end

  def edit
    @health_history = HealthHistory.find_by(id: params[:id])
    if @health_history      
      @child = Child.find_by(health_history_id: @health_history.id)    
      @congenital_heart_defect = CongenitalHeartDefect.find_by(id: @health_history.chd_id)
      @intestinal_issue = IntestinalIssue.find_by(id: @health_history.intestinal_issues_id)
      @gastric_surgery = GastricSurgery.find_by(id: @health_history.gastric_surgery_id)
      @nuerological_condition = NuerologicalCondition.find_by(id: @health_history.nuerological_condition_id)
      @muscular_skeletal = MuscularSkeletal.find_by(id: @health_history.muscular_skeletal_id)
      @cranial_facial = CranialFacial.find_by(id: @health_history.cranial_facial_id)
      @endocrine = Endocrine.find_by(id: @health_history.endocrine_id)
      @hearing = Hearing.find_by(id: @health_history.hearing_id)
      @vision = Vision.find_by(id: @health_history.vision_id)
      @behavioral_health = BehavioralHealth.find_by(id: @health_history.behavioral_health_id)
      @received_therapy = ReceivedTherapy.find_by(id: @health_history.received_therapy_id)
      render 'edit.html.erb'
    else
      flash[:danger] = "Something went wrong: Health History with that ID does not exist"
      redirect_to '/'
    end
  end

  def update
    @health_history = HealthHistory.find_by(id: params[:id])
    @child = Child.find_by(health_history_id: @health_history.id)    
    @congenital_heart_defect = CongenitalHeartDefect.find_by(id: @health_history.chd_id)
    @intestinal_issue = IntestinalIssue.find_by(id: @health_history.intestinal_issues_id)
    @gastric_surgery = GastricSurgery.find_by(id: @health_history.gastric_surgery_id)
    @nuerological_condition = NuerologicalCondition.find_by(id: @health_history.nuerological_condition_id)
    @muscular_skeletal = MuscularSkeletal.find_by(id: @health_history.muscular_skeletal_id)
    @cranial_facial = CranialFacial.find_by(id: @health_history.cranial_facial_id)
    @endocrine = Endocrine.find_by(id: @health_history.endocrine_id)
    @hearing = Hearing.find_by(id: @health_history.hearing_id)
    @vision = Vision.find_by(id: @health_history.vision_id)
    @behavioral_health = BehavioralHealth.find_by(id: @health_history.behavioral_health_id)
    @received_therapy = ReceivedTherapy.find_by(id: @health_history.received_therapy_id)
    if
      @congenital_heart_defect.update(
        asd: params[:asd],
        vsd: params[:vsd],
        pda: params[:pda],
        av_canal_defect: params[:av_canal_defect],
        dorv: params[:dorv],
        tof: params[:tof],
        pfo: params[:pfo],
        not_applicable: params[:not_applicable],
        other: params[:other]
      ) &&
      @intestinal_issue.update(
        duodenal_atresia_stenosis_web: params[:duodenal_atresia_stenosis_web],
        anal_stenosis_atresia: params[:anal_stenosis_atresia],
        esophageal_atresia: params[:esophageal_atresia],
        hirschsprung_disease: params[:hirschsprung_disease],
        chronic_constipation: params[:chronic_constipation],
        dysphagia: params[:dysphagia],
        aspiration: params[:aspiration],
        chronic_diarrhea: params[:chronic_diarrhea],
        pyloric_stenosis: params[:pyloric_stenosis],
        gastroesophageal_reflux: params[:gastroesophageal_reflux],
        pepticulcers_gallstones: params[:pepticulcers_gallstones],
        hemorrhoids: params[:hemorrhoids],
        diverticulitis_diverticulosis: params[:diverticulitis_diverticulosis],
        colorectal_carcinoma: params[:colorectal_carcinoma],
        ibs: params[:ibs],
        ibd: params[:ibd]
      ) &&
      @gastric_surgery.update(
        repair_of_duodenal_atresia_stenosis_web: params[:repair_of_duodenal_atresia_stenosis_web],
        repair_of_anal_stenosis_atresia: params[:repair_of_anal_stenosis_atresia],
        gastrostomy_tube_placement: params[:gastrostomy_tube_placement],
        surgery_for_hirschsprung_disease: params[:surgery_for_hirschsprung_disease],
        fundoplication_nissen_wrap: params[:fundoplication_nissen_wrap],
        none: params[:none],
        other: params[:other_gastric_surgery]
      ) &&
      @nuerological_condition.update(
        seizure_epilepsy: params[:seizure_epilepsy],
        brain_malformation: params[:brain_malformation],
        cyst: params[:cyst],
        cp: params[:cp],
        stroke: params[:stroke],
        unsure: params[:unsure],
        brain_malformation_surgery: params[:brain_malformation_surgery],
        cyst_surgery: params[:cyst_surgery],
        cp_surgery: params[:cp_surgery],
        stroke_surgery: params[:stroke_surgery],
        other: params[:other_nuero_surgery]
      ) &&
      @muscular_skeletal.update(
        atlanto_axial_instability: params[:atlanto_axial_instability],
        cervical_spine_degeneration: params[:cervical_spine_degeneration],
        osteopenia: params[:osteopenia],
        osteoporosis: params[:osteoporosis],
        fractures: params[:fractures],
        scoliosis: params[:scoliosis],
        lordosis: params[:lordosis],
        kyphosis: params[:kyphosis],
        hand_bone_missing: params[:hand_bone_missing],
        leg_bone_missing: params[:leg_bone_missing],
        rib_deformities: params[:rib_deformities],
        club_foot: params[:club_foot],
        rocker_bottom_feet: params[:rocker_bottom_feet],
        atlanto_axial_instability_surgery: params[:atlanto_axial_instability_surgery],
        cervical_spine_degeneration_surgery: params[:cervical_spine_degeneration_surgery],
        osteopenia_surgery: params[:osteopenia_surgery],
        osteoporosis_surgery: params[:osteoporosis_surgery],
        fractures_surgery: params[:fractures_surgery],
        scoliosis_surgery: params[:scoliosis_surgery],
        lordosis_surgery: params[:lordosis_surgery],
        kyphosis_surgery: params[:kyphosis_surgery],
        hand_bone_missing_surgery: params[:hand_bone_missing_surgery],
        leg_bone_missing_surgery: params[:leg_bone_missing_surgery],
        rib_deformities_surgery: params[:rib_deformities_surgery],
        club_foot_surgery: params[:club_foot_surgery],
        rocker_bottom_feet_surgery: params[:rocker_bottom_feet_surgery]
      ) &&
      @cranial_facial.update(
        cranial_deformities: params[:cranial_deformities],
        cleft_palate: params[:cleft_palate],
        cleft_lip: params[:cleft_lip],
        high_arch: params[:high_arch],
        low_set_ears: params[:low_set_ears],
        wide_spaced_eyes: params[:wide_spaced_eyes],
        wild_eyebrows: params[:wild_eyebrows],
        extraordinarily_long_eyelashes: params[:extraordinarily_long_eyelashes],
        overgrowth_of_gums: params[:overgrowth_of_gums],
        delayed_teething: params[:delayed_teething]
      ) &&
      @endocrine.update(
        hyperthyroidism: params[:hyperthyroidism],
        hypothyroidism: params[:hypothyroidism],
        early_onset_pubic_hair: params[:early_onset_pubic_hair],
        early_onset_puberty: params[:early_onset_puberty],
        growth_hormone_deficiency: params[:growth_hormone_deficiency],
        calcium_deficiency: params[:calcium_deficiency],
        high_cortisol: params[:high_cortisol],
        diabetes: params[:diabetes],
        hypoglycemia: params[:hypoglycemia],
        cushings_disease: params[:cushings_disease],
        vitamin_d_deficiency: params[:vitamin_d_deficiency],
        anemia: params[:anemia],
        failure_to_thrive: params[:failure_to_thrive],
        high_blood_pressure: params[:high_blood_pressure],
        low_blood_pressure: params[:low_blood_pressure],
        delayed_late_puberty: params[:delayed_late_puberty],
        unsure: params[:unsure],
        other: params[:other_endocrine],
        high_blood_sugar: params[:high_blood_sugar],
        unhealthy_cholesterol_levels: params[:unhealthy_cholesterol_levels],
        increased_abdominal_fat: params[:increased_abdominal_fat]
      ) &&
      @hearing.update(
        transient: params[:transient],
        conductive: params[:conductive],
        nerve_loss: params[:nerve_loss],
        unknown: params[:unknown],
        other: params[:other_hearing]
      ) &&
      @vision.update(
        cataract: params[:cataract],
        strabismus: params[:strabismus],
        lazy_eye: params[:lazy_eye],
        near_sighted: params[:near_sighted],
        far_sighted: params[:far_sighted],
        cvi: params[:cvi],
        astigmatism: params[:astigmatism],
        ptosis: params[:ptosis],
        blockage_of_tear_duct: params[:blockage_of_tear_duct],
        depth_perception_problems: params[:depth_perception_problems],
        blindness: params[:blindness],
        glaucoma: params[:glaucoma],
        torn_retina: params[:torn_retina],
        detached_retina: params[:detached_retina],
        undeveloped_eyes: params[:undeveloped_eyes],
        underdeveloped_eyes: params[:underdeveloped_eyes],
        undeveloped_eye_socket: params[:undeveloped_eye_socket],
        underdeveloped_eye_socket: params[:underdeveloped_eye_socket],
        dry_eyes: params[:dry_eyes],
        doesnt_blink_well: params[:doesnt_blink_well],
        doesnt_close_eyes_when_sleeping: params[:doesnt_close_eyes_when_sleeping]
      ) &&
      @behavioral_health.update(
        add: params[:add],
        adhd: params[:adhd],
        bipolar: params[:bipolar],
        autism_spectrum: params[:autism_spectrum],
        depression: params[:depression],
        anxiety_disorder: params[:anxiety_disorder],
        ocd: params[:ocd],
        schizophrenia: params[:schizophrenia],
        addictions: params[:addictions],
        personality_disorder: params[:personality_disorder],
        eating_disorder: params[:eating_disorder],
        odd: params[:odd],
        other_delay: params[:other_delay],
        other_diagnosis: params[:other_diagnosis],
        conduct_disorder: params[:conduct_disorder],
        none: params[:none],
        learning_disability: params[:learning_disability],
        global_developmental_delay: params[:global_developmental_delay],
        intellectual_disability: params[:intellectual_disability],
        speech_delay: params[:speech_delay],
        receptive_delay: params[:receptive_delay],
        expressive_delay: params[:expressive_delay],
        auditory_processing_disorder: params[:auditory_processing_disorder],
        apraxia_dyspraxia: params[:apraxia_dyspraxia],
        visual_processing: params[:visual_processing]
      ) &&
      @received_therapy.update(
        ot: params[:ot],
        pt: params[:pt],
        dt: params[:dt],
        st: params[:st],
        dtv: params[:dtv],
        dth: params[:dth],
        vital_stim: params[:vital_stim],
        aquatic: params[:aquatic],
        reflex_integration: params[:reflex_integration],
        hippotherapy_equine: params[:hippotherapy_equine],
        hyperbaric: params[:hyperbaric],
        other: params[:other_therapy]
      ) &&
      @health_history.update(
        chd: params[:chd],
        chd_id: @congenital_heart_defect.id,
        offered_cardiac_surgery: params[:offered_cardiac_surgery],
        first_cardiac_surgery_age: params[:first_cardiac_surgery_age][0],
        first_cardiac_surgery_successful: params[:first_cardiac_surgery_successful],
        multiple_cardiac_surgeries: params[:multiple_cardiac_surgeries],
        intestinal_issues_id: @intestinal_issue.id,
        gastric_surgery_id: @gastric_surgery.id,
        seizure_epilepsy: params[:seizure_epilepsy],
        nuerological_condition_id: @nuerological_condition.id,
        muscular_skeletal_id: @muscular_skeletal.id,
        sleep_apnea: params[:sleep_apnea],
        cranial_facial_id: @cranial_facial.id,
        cancer: params[:cancer],
        other_cancer: params[:cancer_other],
        endocrine_id: @endocrine.id,
        hearing_test: params[:hearing_test],
        had_an_abr: params[:had_an_abr],
        hearing_loss_or_deaf: params[:hearing_loss_or_deaf],
        hearing_loss_treatment: params[:hearing_loss_treatment],
        failed_eye_exam: params[:failed_eye_exam],
        hearing_id: @hearing.id,
        vision_id: @vision.id,
        behavioral_health_id: @behavioral_health.id,
        in_ei: params[:in_ei],
        attend_school: params[:attend_school],
        home_schooled_bound: params[:home_schooled_bound],
        highest_education: params[:highest_education],
        received_therapy_id: @received_therapy.id,
        clinical_trial: params[:clinical_trial],
        clinical_trial_participation: params[:clinical_trial_participation]
      ) &&
      @child.update(
        health_history_id: @health_history.id
      )
      flash[:success] = "Health History Successfully Updated!"
      redirect_to "/profile/#{@child.id}"
    else
      flash[:warning] = "Health History Could Not Be Updated!"
      render 'edit.html.erb'
    end
  end

end